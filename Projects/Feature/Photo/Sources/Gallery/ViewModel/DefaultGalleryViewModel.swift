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
import CoreStorageInterfaces

public final class DefaultGalleryViewModel: GalleryViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let actions: GalleryViewModelAction
    
    public let fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase
    public let fetchAssetImageDataUsecase: any FetchAssetImageDataUsecase
    public let savePhotoUsecaes: SavePhotoUsecase
    
    public init(
        fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase,
        fetchAssetImageDataUsecase: FetchAssetImageDataUsecase,
        savePhotoUsecaes: SavePhotoUsecase,
        actions: GalleryViewModelAction
    ) {
        self.fetchPhotoAssetsUsecase = fetchPhotoAssetsUsecase
        self.fetchAssetImageDataUsecase = fetchAssetImageDataUsecase
        self.savePhotoUsecaes = savePhotoUsecaes
        self.actions = actions
    }
    
    public func transform(input: Input) -> Output {
        let selectedItems: BehaviorRelay<[GalleryItemViewModel]> = .init(value: [])
        let photos: BehaviorRelay<[GalleryItemViewModel]> = .init(value: [])
        
        let authResult = input.viewDidLoad
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.requestPhotoLibraryPermission()
            }
            .share()
        
        authResult
            .filter { $0 }
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.fetchPhotoAssetsUsecase.execute(size: .thumbnail)
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
                var items = selectedItems.value
                if let idx = items.firstIndex(where: { item in
                    item.idx == idx
                }) {
                    values[items[idx].idx].selectedIdx = nil
                    items.remove(at: idx)
                    
                    for i in 0..<items.count {
                        items[i].selectedIdx = i + 1
                        values[items[i].idx].selectedIdx = i + 1
                    }
                } else {
                    values[idx].selectedIdx = items.count + 1
                    items.append(values[idx])
                }
                
                photos.accept(values)
                selectedItems.accept(items)
            }
            .disposed(by: disposeBag)
        
        input.cancelButtonTapped?
            .map { _ -> [FileInfo] in
                return []
            }
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        input.selectButtonTapped?
            .map { selectedItems.value }
            .withUnretained(self)
            .flatMap { owner, items in
                Observable.from(items.map { $0.asset })
                    .flatMap { owner.savePhotoUsecaes.execute(asset: $0).map { fileName-> FileInfo? in fileName }.catchAndReturn(nil) }
                    .toArray()
            }
            .map { $0.compactMap { $0 } }
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        return .init(
            cellItems: photos.asDriver(),
            selectedCount: selectedItems.asDriver().map { $0.count }
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
