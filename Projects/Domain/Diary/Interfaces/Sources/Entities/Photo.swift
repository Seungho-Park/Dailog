//
//  Photo.swift
//  DomainWrite
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces

public struct Photo {
    public let fileName: String
    public let memo: String
    public let createdAt: Date
    
    public init(fileName: String, memo: String, createdAt: Date) {
        self.fileName = fileName
        self.memo = memo
        self.createdAt = createdAt
    }
}

public extension PhotoStorageDTO {
    func toDomain()-> Photo {
        return .init(fileName: fileName, memo: memo, createdAt: createdAt)
    }
}
