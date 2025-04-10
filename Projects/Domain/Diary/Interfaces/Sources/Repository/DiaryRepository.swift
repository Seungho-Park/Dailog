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
    func save(diary: NewDiary, completion: @escaping (Result<NewDiary, CoreDataStorageError>)-> Void)
    func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<NewDiaries, CoreDataStorageError>)-> Void)
    func delete(diary: NewDiary, completion: @escaping (Result<Bool, CoreDataStorageError>)-> Void)
}
