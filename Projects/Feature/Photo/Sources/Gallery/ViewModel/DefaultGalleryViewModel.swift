//
//  DefaultAlbumViewModel.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift
import RxCocoa
import Photos
import FeaturePhotoInterfaces
import DomainPhotoInterfaces
import UIKit

public final class DefaultGalleryViewModel: GalleryViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let actions: GalleryViewModelAction
    
    public let fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase
    public let fetchAssetImageDataUsecase: any FetchAssetImageDataUsecase
    
    public init(
        fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase,
        fetchAssetImageDataUsecase: FetchAssetImageDataUsecase,
        actions: GalleryViewModelAction
    ) {
        self.fetchPhotoAssetsUsecase = fetchPhotoAssetsUsecase
        self.fetchAssetImageDataUsecase = fetchAssetImageDataUsecase
        self.actions = actions
    }
    
    public func transform(input: Input) -> Output {
        var selectedItems: [GalleryItemViewModel] = []
        let photos: BehaviorRelay<[GalleryItemViewModel]> = .init(value: [])
        
        let authResult = input.viewDidLoad
            .debug()
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.requestPhotoLibraryPermission()
            }
            .share()
        
        authResult
            .filter { $0 }
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.fetchPhotoAssetsUsecase.execute(size: .init(width: 150, height: 150))
            }
            .withUnretained(self)
            .map { owner, items in
                items.enumerated().map { [unowned owner] in
                    GalleryItemViewModel.init(idx: $0.offset, asset: $0.element, image: owner.fetchAssetImageData(asset:completion:))
                }
            }
            .bind(to: photos)
            .disposed(by: disposeBag)
        
        input.itemSelected
            .bind { idx in
                var values = photos.value
                if let idx = selectedItems.firstIndex(where: { item in
                    item.idx == idx
                }) {
                    values[selectedItems[idx].idx].selectedIdx = nil
                    selectedItems.remove(at: idx)
                    
                    for i in 0..<selectedItems.count {
                        selectedItems[i].selectedIdx = i + 1
                        values[selectedItems[i].idx].selectedIdx = i + 1
                    }
                } else {
                    values[idx].selectedIdx = selectedItems.count + 1
                    selectedItems.append(values[idx])
                }
                
                photos.accept(values)
            }
            .disposed(by: disposeBag)
        
        input.cancelButtonTapped?
            .map { _ -> [PHAsset] in
                return []
            }
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        return .init(
            cellItems: photos.asDriver()
        )
    }
    
    private func requestPhotoLibraryPermission() -> Observable<Bool> {
        return Observable.create { observer in
            let status = PHPhotoLibrary.authorizationStatus()
            
            if status == .notDetermined {
                PHPhotoLibrary.requestAuthorization { newStatus in
                    DispatchQueue.main.async {
                        observer.onNext(newStatus == .authorized)
                        observer.onCompleted()
                    }
                }
            } else {
                observer.onNext(status == .authorized)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchAllPhotos()-> Observable<[PHAsset]> {
        return Observable<[PHAsset]>.create { observer in
            var assets: [PHAsset] = []
            
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            
            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            fetchResult.enumerateObjects { (asset, _, _) in
                assets.append(asset)
            }
            
            observer.onNext(assets)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    private func fetchAssetImageData(asset: PHAsset, completion: @escaping (Data?)-> Void) {
        fetchAssetImageDataUsecase.execute(asset: asset)
            .map { data-> Data? in return data }
            .catchAndReturn(nil)
            .subscribe {
                completion($0)
            }
            .disposed(by: disposeBag)
    }
}
