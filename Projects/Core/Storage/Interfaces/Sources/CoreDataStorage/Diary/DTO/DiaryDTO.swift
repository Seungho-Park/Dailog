//
//  DiaryDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryDTO {
    public let id: UUID
    public let emotion: Int16
    public let contents: [DiaryContentDTO]
    public let date: Date
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(id: UUID, emotion: Int16, contents: [DiaryContentDTO], date: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.emotion = emotion
        self.contents = contents
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
