//
//  DiaryDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryStorageDTO {
    public let id: UUID
    public let emotion: Int16?
    public let contents: String
    public let photos: [PhotoStorageDTO]
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(id: UUID, emotion: Int16?, contents: String, photos: [PhotoStorageDTO], createdAt: Date, updatedAt: Date) {
        self.id = id
        self.emotion = emotion
        self.contents = contents
        self.photos = photos
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
