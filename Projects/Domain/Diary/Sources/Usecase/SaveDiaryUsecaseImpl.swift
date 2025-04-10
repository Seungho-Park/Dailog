//
//  SaveDiaryUsecaseImpl.swift
//  DomainWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import DomainDiaryInterfaces

public final class SaveDiaryUsecaseImpl: SaveDiaryUsecase {
    private let repository: DiaryRepository
    
    public init(repository: DiaryRepository) {
        self.repository = repository
    }
    
    public func execute(diary: NewDiary) -> Single<NewDiary> {
        return .create { [unowned self] single in
            self.repository.save(diary: diary) { result in
                switch result {
                case .success(let diary):
                    single(.success(diary))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
