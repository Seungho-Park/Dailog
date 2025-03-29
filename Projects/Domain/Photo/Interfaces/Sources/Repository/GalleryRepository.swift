//
//  PhotoRepository.swift
//  Domain
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import CorePhotoInterfaces

public protocol GalleryRepository {
    func reuqestAuthorization(completion: @escaping (Result<Void, PhotoServiceError>)-> Void)
    func fetchAllPhotos(size: PhotoSize, completion: @escaping (Result<[PHAsset], PhotoServiceError>)-> Void)
    func fetchAssetImageData(asset: PHAsset, size: PhotoSize, completion: @escaping (Result<Data, PhotoServiceError>)-> Void)
    func clear()
}
