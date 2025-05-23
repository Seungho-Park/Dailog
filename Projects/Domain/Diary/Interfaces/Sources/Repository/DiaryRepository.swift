//
//  DiaryRepository.swift
//  DomainWrite
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces

public protocol DiaryRepository {
    func save(diary: Diary, completion: @escaping (Result<Diary, CoreDataStorageError>)-> Void)
    func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<Diaries, CoreDataStorageError>)-> Void)
    func delete(diary: Diary, completion: @escaping (Result<Bool, CoreDataStorageError>)-> Void)
}
