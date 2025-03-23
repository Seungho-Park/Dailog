//
//  FetchPhotoDataUsecaseImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import DomainPhotoInterfaces
import CoreStorageInterfaces

public final class FetchPhotoDataUsecaseImpl: FetchPhotoDataUsecase {
    private let repository: PhotoStorageRepository
    
    public init(repository: PhotoStorageRepository) {
        self.repository = repository
    }
    
    public func execute(fileName: String) -> Single<FileInfo> {
        return .create { [unowned self] single in
            repository.fetchPhoto(fileName: fileName) { result in
                switch result {
                case .success(let file):
                    single(.success(file))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
