//
//  PhotoRepository.swift
//  Domain
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import CorePhotoInterfaces

public protocol PhotoRepository {
    func reuqestAuthorization(completion: @escaping (Result<Void, PhotoServiceError>)-> Void)
    func fetchAllPhotos(size: CGSize, completion: @escaping (Result<[PHAsset], PhotoServiceError>)-> Void)
    func fetchAssetImageData(asset: PHAsset, completion: @escaping (Result<Data, PhotoServiceError>)-> Void)
}
