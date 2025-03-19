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

public final class DefaultGalleryViewModel: GalleryViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    
    public init() {  }
    
    public func transform(input: Input) -> Output {
        let photos: BehaviorRelay<[AlbumItemCellViewModel]> = .init(value: [])
        
        let authResult = input.viewWillAppear
            .take(1)
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.requestPhotoLibraryPermission()
            }
            .share()
        
        authResult
            .filter { $0 }
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.fetchAllPhotos()
            }
            .map {
                $0.enumerated().map { AlbumItemCellViewModel(idx: $0.offset, photo: $0.element) }
            }
            .bind(to: photos)
            .disposed(by: disposeBag)
        
        return .init(
            
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
}
