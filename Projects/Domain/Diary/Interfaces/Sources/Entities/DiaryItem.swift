//
//  Diary.swift
//  DomainWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces

public struct Diaries {
    public let currentPage: Int
    public let totalPages: Int
    public let diaries: [Diary]
    
    public init(currentPage: Int, totalPages: Int, diaries: [Diary]) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.diaries = diaries
    }
}

public struct Diary {
    public let id: UUID
    public let emotion: Emotion?
    public let contents: String
    public let date: Date
    public let photos: [Photo]
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(id: UUID, emotion: Emotion?, contents: String, date: Date, photos: [Photo], createdAt: Date, updatedAt: Date) {
        self.id = id
        self.emotion = emotion
        self.contents = contents
        self.date = date
        self.photos = photos
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public extension DiaryStorageDTO {
    func toDomain() -> Diaries {
        return .init(currentPage: self.currentPage, totalPages: self.totalPage, diaries: self.diaries.map { $0.toDomain() })
    }
}

public extension DiaryStorageDTO.DiaryItem {
    func toDomain()-> Diary {
        return .init(id: self.id, emotion: self.emotion != nil ? Emotion(rawValue: self.emotion!) : nil, contents: self.contents, date: self.date, photos: self.photos.map { $0.toDomain() }, createdAt: self.createdAt, updatedAt: self.updatedAt)
    }
}
