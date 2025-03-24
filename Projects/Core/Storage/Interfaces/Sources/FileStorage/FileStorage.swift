//
//  Storage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public enum FileStorageError: Error {
    case emptyData
    case saveError(Error)
    case convertError
    case fileNotExist
    case fetchError(Error)
    case removeError(Error)
}

public protocol FileStorage {
    func save(data: Data?, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void)
    func fetch(fileName: String, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void)
    func remove(fileName: String, completion: @escaping (Result<Bool, FileStorageError>)-> Void)
}
