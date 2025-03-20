//
//  PhotoRepositoryImpl.swift
//  Domain
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import DomainPhotoInterfaces
import CorePhotoInterfaces

public final class PhotoRepositoryImpl: PhotoRepository {
    
    private let photoService: PhotoService
    
    public init(photoService: PhotoService) {
        self.photoService = photoService
    }
    
    public func reuqestAuthorization(completion: @escaping (Result<Void, CorePhotoInterfaces.PhotoServiceError>) -> Void) {
        photoService.requestAuthorization(completion: completion)
    }
    
    public func fetchAllPhotos(size: CGSize, completion: @escaping (Result<[PHAsset], PhotoServiceError>)-> Void) {
        photoService.fetchPhotos(size: size, completion: completion)
    }
    
    public func fetchAssetImageData(asset: PHAsset, completion: @escaping (Result<Data, PhotoServiceError>) -> Void) {
        photoService.requestImageData(asset: asset, completion: completion)
    }
}
