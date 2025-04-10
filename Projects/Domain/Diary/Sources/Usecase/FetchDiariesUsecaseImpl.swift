//
//  FetchDiariesUsecaseImpl.swift
//  DomainDiary
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import DomainDiaryInterfaces

public final class FetchDiariesUsecaseImpl: FetchDiariesUsecase {
    private let repository: DiaryRepository
    
    public init(repository: DiaryRepository) {
        self.repository = repository
    }
    
    public func execute(year: Int?, month: Int?, page: Int, count: Int) -> Single<NewDiaries> {
        return .create { [unowned self] single in
            
            repository.fetchDiaries(year: year, month: month, page: page, count: count) { result in
                switch result {
                case .success(let diaries):
                    single(.success(diaries))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
