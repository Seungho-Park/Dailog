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
    private var cache: NSCache<NSString, NSData> = .init()
    
    public let disposeBag: DisposeBag = DisposeBag()
    
    public init() {  }
    
    public func transform(input: Input) -> Output {
        var selectedItems: [GalleryItemViewModel] = []
        let photos: BehaviorRelay<[GalleryItemViewModel]> = .init(value: [])
        
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
            .withUnretained(self)
            .flatMap { owner, assets in
                Observable<[GalleryItemViewModel]>.create { [weak owner] observer in
                    owner?.assetToViewModel(assets: assets, completion: { viewModels in
                        observer.onNext(viewModels)
                        observer.onCompleted()
                    })
                    
                    return Disposables.create()
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
    
    private func assetToViewModel(assets: [PHAsset], completion: @escaping ([GalleryItemViewModel]) -> Void) {
        var resultDict: [Int: GalleryItemViewModel] = [:]
        let group = DispatchGroup()
        
        let imageManager = PHImageManager.default()
        let targetSize = CGSize(width: 250, height: 250)
        let options = PHImageRequestOptions()
        options.isSynchronous = false
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        for i in 0..<assets.count {
            let asset = assets[i]
            group.enter()
            
            if let cachedImage = cache.object(forKey: asset.localIdentifier as NSString) {
                let imageData = Data(cachedImage)
                resultDict[i] = GalleryItemViewModel(idx: i, photo: imageData, selectedIdx: nil)
                group.leave()
            } else {
                imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFill, options: options) { image, _ in
                    if let imageData = image?.pngData() {
                        resultDict[i] = GalleryItemViewModel(idx: i, photo: imageData, selectedIdx: nil)
                        self.cache.setObject(imageData as NSData, forKey: asset.localIdentifier as NSString)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            completion((0..<assets.count).compactMap { resultDict[$0] })
        }
    }
}
