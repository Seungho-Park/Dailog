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
}

public protocol FileStorage {
    func save(data: Data?, completion: @escaping (Result<String, FileStorageError>)-> Void)
}
