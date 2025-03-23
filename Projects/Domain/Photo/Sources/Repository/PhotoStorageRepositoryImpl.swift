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
    
    public func save(asset: PHAsset, completion: @escaping (Result<FileInfo, FileStorageError>) -> Void) {
        photoService.requestImageData(asset: asset, size: .original) { [weak self] result in
            switch result {
            case .success(let data):
                autoreleasepool { [weak self] in
                    self?.fileStorage.save(data: data, completion: completion)
                }
            case .failure(let error):
                completion(.failure(.saveError(error)))
            }
        }
    }
    
    public func save(data: Data?, completion: @escaping (Result<FileInfo, FileStorageError>) -> Void) {
        fileStorage.save(data: data, completion: completion)
    }
    
    public func fetchPhoto(fileName: String, completion: @escaping (Result<FileInfo, FileStorageError>) -> Void) {
        fileStorage.fetch(fileName: fileName, completion: completion)
    }
    
    public func remove(fileName: String, completion: @escaping (Result<Bool, FileStorageError>) -> Void) {
        fileStorage.remove(fileName: fileName, completion: completion)
    }
}
