//
//  PhotoStoageRepositoryImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CorePhotoInterfaces
import CoreStorageInterfaces
import DomainPhotoInterfaces
import Photos

public final class PhotoStorageRepositoryImpl: PhotoStorageRepository {
    private let fileStorage: FileStorage
    private let photoService: PhotoService
    
    public init(fileStorage: FileStorage, photoService: PhotoService) {
        self.fileStorage = fileStorage
        self.photoService = photoService
    }
    
    public func save(asset: PHAsset, completion: @escaping (Result<String, FileStorageError>) -> Void) {
        photoService.requestImageData(asset: asset, size: .original) { [weak self] result in
            guard let self else {
                completion(.failure(.emptyData))
                return
            }
            switch result {
            case .success(let data):
                self.fileStorage.save(data: data, completion: completion)
            case .failure(let error):
                completion(.failure(.saveError(error)))
            }
        }
    }
    
    public func save(data: Data?, completion: @escaping (Result<String, FileStorageError>) -> Void) {
        fileStorage.save(data: data, completion: completion)
    }
}
