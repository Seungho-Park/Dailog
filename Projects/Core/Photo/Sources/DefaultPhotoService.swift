//
//  DefaultPhotoService.swift
//  CorePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import PhotosUI
import Photos
import CorePhotoInterfaces

public final class DefaultPhotoService: PhotoService {
    private let photoManager: PHImageManager
    private let photoRequestOptions: PHImageRequestOptions
    private var size: CGSize = .zero
    
    public init(photoManager: PHImageManager = PHCachingImageManager.default()) {
        self.photoManager = photoManager
        photoRequestOptions = PHImageRequestOptions()
        photoRequestOptions.isSynchronous = true
        photoRequestOptions.deliveryMode = .opportunistic
        photoRequestOptions.isNetworkAccessAllowed = true
        photoRequestOptions.resizeMode = .fast
    }
    
    public func requestAuthorization(completion: @escaping (Result<Void, PhotoServiceError>) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    completion(.success(()))
                }
            }
        } else {
            completion(.failure(.unauthorized))
        }
    }
    
    public func fetchPhotos(size: CGSize = .init(width: 150, height: 150), completion: @escaping (Result<[PHAsset], PhotoServiceError>)-> Void) {
        self.size = size
        guard PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized else {
            completion(.failure(.unauthorized))
            return
        }
        
        var assets: [PHAsset] = []
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        fetchResult.enumerateObjects { (asset, _, _) in
            assets.append(asset)
        }
        
        if let cachingImageManager = photoManager as? PHCachingImageManager {
            cachingImageManager.startCachingImages(for: assets, targetSize: size, contentMode: .aspectFill, options: photoRequestOptions)
        }
        completion(.success(assets))
    }
    
    public func requestImageData(asset: PHAsset, completion: @escaping (Result<Data, PhotoServiceError>) -> Void) {
        photoManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: photoRequestOptions) { image, _ in
            if let imageData = image?.pngData() {
                completion(.success(imageData))
            } else {
                completion(.failure(.noResponse))
            }
        }
    }
    
    public func clear() {
        guard let cachingImageManager = photoManager as? PHCachingImageManager else { return }
        cachingImageManager.stopCachingImagesForAllAssets()
    }
}
