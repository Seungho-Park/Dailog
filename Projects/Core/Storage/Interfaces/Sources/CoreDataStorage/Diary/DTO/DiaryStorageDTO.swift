//
//  DiaryDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryStorageDTO {
    public let currentPage: Int
    public let totalPage: Int
    public let diaries: [DiaryItem]
    
    public init(currentPage: Int, totalPage: Int, diaries: [DiaryItem]) {
        self.currentPage = currentPage
        self.totalPage = totalPage
        self.diaries = diaries
    }
}

public extension DiaryStorageDTO {
    struct DiaryItem {
        public let id: UUID
        public let emotion: Int16?
        public let contents: String
        public let date: Date
        public let photos: [PhotoStorageDTO]
        public let createdAt: Date
        public let updatedAt: Date
        
        public init(id: UUID, emotion: Int16?, contents: String, date: Date, photos: [PhotoStorageDTO], createdAt: Date, updatedAt: Date) {
            self.id = id
            self.emotion = emotion
            self.contents = contents
            self.date = date
            self.photos = photos
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
}
