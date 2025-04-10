//
//  DeleteDiaryUsecaseImpl.swift
//  DomainDiary
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import DomainDiaryInterfaces

public final class DeleteDiaryUsecaseImpl: DeleteDiaryUsecase {
    private let repository: DiaryRepository
    
    public init(repository: DiaryRepository) {
        self.repository = repository
    }
    
    public func execute(diary: NewDiary) -> Single<Bool> {
        return Single<Bool>.create { [unowned self] single in
            self.repository.delete(diary: diary) { result in
                switch result {
                case .success(let isSuccess): single(.success(isSuccess))
                case .failure(let error): single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
