//
//  PhotoStorageDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct PhotoStorageDTO {
    public let fileName: String
    public let memo: String
    public let createdAt: Date
    
    public init(fileName: String, memo: String, createdAt: Date) {
        self.fileName = fileName
        self.memo = memo
        self.createdAt = createdAt
    }
}
