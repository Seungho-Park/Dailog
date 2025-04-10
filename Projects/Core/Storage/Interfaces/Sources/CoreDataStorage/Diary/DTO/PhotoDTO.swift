//
//  PhotoDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct PhotoDTO {
    public let fileName: String
    public let memo: String
    public let createdAt: Date
    public let width: Double
    
    public init(fileName: String, memo: String, width: Double, createdAt: Date) {
        self.fileName = fileName
        self.memo = memo
        self.width = width
        self.createdAt = createdAt
    }
}
