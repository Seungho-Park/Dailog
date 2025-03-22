//
//  PhotoService.swift
//  CorePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import Photos

public protocol PhotoService {
    
    func requestAuthorization(completion: @escaping (Result<Void, PhotoServiceError>)-> Void)
    func fetchPhotos(size: PhotoSize, completion: @escaping (Result<[PHAsset], PhotoServiceError>)-> Void)
    func requestImageData(asset: PHAsset, size: PhotoSize, completion: @escaping (Result<Data, PhotoServiceError>)-> Void)
    func clear()
}
