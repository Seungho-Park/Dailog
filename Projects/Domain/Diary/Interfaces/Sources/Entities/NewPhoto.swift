//
//  NewPhoto.swift
//  DomainDiary
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces

public struct NewPhoto {
    public let fileName: String
    public let memo: String
    public let width: Double
    public let createdAt: Date
    
    public init(fileName: String, memo: String, width: Double, createdAt: Date) {
        self.fileName = fileName
        self.memo = memo
        self.width = width
        self.createdAt = createdAt
    }
}

public extension PhotoDTO {
    func toDomain()-> NewPhoto {
        return .init(fileName: fileName, memo: memo, width: width, createdAt: createdAt)
    }
}
