//
//  PhotoStorageRepository.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import CoreStorageInterfaces

public protocol PhotoStorageRepository {
    func save(data: Data?, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void)
    func save(asset: PHAsset, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void)
    
    func fetchPhoto(fileName: String, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void)
    func remove(fileName: String, completion: @escaping (Result<Bool, FileStorageError>)-> Void)
}
