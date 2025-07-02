//
//  UserEntity+Mapping.swift
//  CoreStorage
//
//  Created by 박승호 on 6/30/25.
//

import Foundation
import CoreData

@objc(UserEntity)
public final class UserEntity: NSManagedObject {
    @NSManaged public var uuid: UUID
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }
}


// MARK: - Mapping
public extension UserEntity {
    func toDomain()-> User {
        return .init(uuid: uuid)
    }
}
