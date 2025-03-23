//
//  SavePhotoUsecaseImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import DomainPhotoInterfaces
import Photos
import CoreStorageInterfaces

public final class SavePhotoUsecaseImpl: SavePhotoUsecase {
    private let repoisitory: PhotoStorageRepository
    
    public init(repoisitory: PhotoStorageRepository) {
        self.repoisitory = repoisitory
    }
    
    public func execute(data: Data?) -> Single<FileInfo> {
        return Single<FileInfo>.create { [unowned self] single in
            self.repoisitory.save(data: data) { result in
                switch result {
                case .success(let file): single(.success(file))
                case .failure(let error): single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func execute(asset: PHAsset) -> Single<FileInfo> {
        return .create { [unowned self] single in
            self.repoisitory.save(asset: asset) { result in
                switch result {
                case .success(let file): single(.success(file))
                case .failure(let error): single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
