//
//  PhotoService.swift
//  CorePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import Photos

public protocol PhotoService {
    
    func fetchPhotos(size: CGSize)-> [PHAsset]
    func requestImageData(asset: PHAsset, completion: @escaping (Result<Data, PhotoServiceError>)-> Void)
    func clear()
}
