//
//  DeletePhotoFileUsecaseImpl.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import DomainPhotoInterfaces
import RxSwift

public final class DeletePhotoFileUsecaseImpl: DeletePhotoFileUsecase {
    private let repository: PhotoStorageRepository
    
    public init(repository: PhotoStorageRepository) {
        self.repository = repository
    }
    
    public func execute(fileName: String) -> Single<Bool> {
        return .create { [unowned self] single in
            self.repository.remove(fileName: fileName) { result in
                switch result {
                case .success(let isSuccess): single(.success(isSuccess))
                case .failure(let error): single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
