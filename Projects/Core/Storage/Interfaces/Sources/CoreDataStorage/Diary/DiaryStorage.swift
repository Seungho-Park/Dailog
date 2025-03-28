//
//  DiaryCoreDataStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public protocol DiaryStorage {
    func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<DiaryStorageDTO, CoreDataStorageError>)-> Void)
    func save(diary: DiaryStorageDTO.DiaryItem, completion: @escaping (Result<DiaryStorageDTO.DiaryItem, CoreDataStorageError>)-> Void)
    func remove(diary: DiaryStorageDTO.DiaryItem, completion: @escaping (Result<DiaryStorageDTO.DiaryItem, CoreDataStorageError>)-> Void)
}
