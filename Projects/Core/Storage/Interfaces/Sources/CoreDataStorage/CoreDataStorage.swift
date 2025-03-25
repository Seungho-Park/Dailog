//
//  CoreDataStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreData

public enum CoreDataStorageError: Error {
    case fetchError(Error)
    case saveError(Error)
    case removeError(Error)
}

public protocol CoreDataStorage {
    func save()
    func performBackgroundTask(_ block: @escaping (NSManagedObjectContext)-> Void)
}
