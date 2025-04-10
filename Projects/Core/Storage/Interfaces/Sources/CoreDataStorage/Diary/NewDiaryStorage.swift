//
//  NewDiaryStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public protocol NewDiaryStorage {
    func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<NewDiaryDTO, CoreDataStorageError>)-> Void)
    func saveDiary(diary: NewDiaryDTO.DiaryEntity, completion: @escaping (Result<NewDiaryDTO.DiaryEntity, CoreDataStorageError>)-> Void)
    func deleteDiary(id: UUID, completion: @escaping (Result<NewDiaryDTO.DiaryEntity, CoreDataStorageError>)-> Void)
}
