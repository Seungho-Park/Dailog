//
//  DiaryRepositoryImpl.swift
//  DomainWrite
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import DomainDiaryInterfaces
import CoreStorageInterfaces

public final class DiaryRepositoryImpl: DiaryRepository {
    private let storage: DiaryStorage
    
    public init(storage: DiaryStorage) {
        self.storage = storage
    }
    
    public func save(diary: Diary, completion: @escaping (Result<Diary, CoreDataStorageError>) -> Void) {
        storage.save(
            diary: diary.toDTO()
        ) { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<Diaries, CoreDataStorageError>) -> Void) {
        storage.fetchDiaries(year: year, month: month, page: page, count: count) { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func delete(diary: Diary, completion: @escaping (Result<Bool, CoreDataStorageError>) -> Void) {
        storage.remove(diary: diary.toDTO()) { result in
            switch result {
            case .success: completion(.success(true))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
