//
//  DefaultCoreDataStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreStorageInterfaces
import CoreData

public final class DefaultCoreDataStorage: CoreDataStorage {
    
    private let persistentContainer: NSPersistentContainer
    
    public init(persistentContainer: NSPersistentContainer? = nil) {
        guard let persistentContainer else {
            let container = NSPersistentContainer(name: "CoreDataStorage", managedObjectModel: .init(contentsOf: Bundle.module.url(forResource: "CoreDataStorage", withExtension: "momd")!)!)
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    assertionFailure("CoreDataStorage Unresolved error \(error), \(error.userInfo)")
                }
            }
            self.persistentContainer = container
            return
        }
        
        self.persistentContainer = persistentContainer
    }
    
    public func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                assertionFailure("CoreDataStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.performBackgroundTask(block)
    }
}
