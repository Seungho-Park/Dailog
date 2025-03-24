//
//  FileInfo.swift
//  CoreStorage
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct FileInfo {
    public let fileName: String
    public let data: Data
    public let createdAt: Date
    
    public init(fileName: String, data: Data, createdAt: Date = Date()) {
        self.fileName = fileName
        self.data = data
        self.createdAt = createdAt
    }
}
