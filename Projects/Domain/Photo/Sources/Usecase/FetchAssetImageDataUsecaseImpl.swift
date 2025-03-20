//
//  FetchAssetImageDataUsecaseImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import Photos
import DomainPhotoInterfaces
import CorePhotoInterfaces
import RxSwift

public final class FetchAssetImageDataUsecaseImpl: FetchAssetImageDataUsecase {
    private let repository: PhotoRepository
    
    public init(repository: PhotoRepository) {
        self.repository = repository
    }
    
    public func execute(asset: PHAsset) -> Single<Data> {
        return .create { [weak self] single in
            guard let self = self else {
                single(.failure(PhotoServiceError.noResponse))
                return Disposables.create()
            }
            
            self.repository
                .fetchAssetImageData(asset: asset) { result in
                    switch result {
                    case .success(let data):
                        single(.success(data))
                    case .failure(let error):
                        single(.failure(error))
                    }
                }
            
            return Disposables.create()
        }
    }
}
