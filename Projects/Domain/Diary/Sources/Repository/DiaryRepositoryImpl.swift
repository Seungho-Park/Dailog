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
    private let storage: NewDiaryStorage
    
    public init(storage: NewDiaryStorage) {
        self.storage = storage
    }
    
    public func save(diary: NewDiary, completion: @escaping (Result<NewDiary, CoreDataStorageError>) -> Void) {
        storage.saveDiary(
            diary: .init(id: diary.id, emotion: diary.emotion?.rawValue, contents: diary.contents.map { DiaryContentDTO(id: $0.id, type: $0.type, text: $0.text, orderIdx: $0.orderIdx, photo: $0.photo.map { PhotoDTO(fileName: $0.fileName, memo: $0.memo, width: $0.width, createdAt: $0.createdAt) }) }, thumbnail: diary.thumbnail.map { DiaryContentDTO(id: $0.id, type: $0.type, text: $0.text, orderIdx: $0.orderIdx, photo: $0.photo.map { PhotoDTO(fileName: $0.fileName, memo: $0.memo, width: $0.width, createdAt: $0.createdAt) }) }, date: diary.date, createdAt: diary.createdAt, updatedAt: diary.updatedAt)
        ) { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<NewDiaries, CoreDataStorageError>) -> Void) {
        storage.fetchDiaries(year: year, month: month, page: page, count: count) { result in
            switch result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func delete(diary: NewDiary, completion: @escaping (Result<Bool, CoreDataStorageError>) -> Void) {
        storage.deleteDiary(id: diary.id) { result in
            switch result {
            case .success: completion(.success(true))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
