//
//  FetchPhotoAssetsUsecaseImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import DomainPhotoInterfaces
import CorePhotoInterfaces
import RxSwift

public final class FetchPhotoAssetsUsecaseImpl: FetchPhotoAssetsUsecase {
    private let repository: PhotoRepository
    
    public init(repository: PhotoRepository) {
        self.repository = repository
    }
    
    public func execute(size: CGSize) -> Single<[PHAsset]> {
        return Single<[PHAsset]>.create { [weak self] single in
            guard let self = self else {
                single(.failure(PhotoServiceError.noResponse))
                return Disposables.create()
            }
            
            self.repository.fetchAllPhotos(size: size) { result in
                switch result {
                case .success(let assets):
                    single(.success(assets))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
