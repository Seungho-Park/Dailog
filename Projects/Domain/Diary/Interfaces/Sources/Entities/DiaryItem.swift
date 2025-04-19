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
    public let contents: [DiaryContent]
    public let date: Date
    public let createdAt: Date
    public let updatedAt: Date
    
    
    public init(id: UUID, emotion: Emotion?, contents: [DiaryContent], date: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.emotion = emotion
        self.contents = contents
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public extension Diary {
    func toDTO()-> DiaryDTO {
        .init(
            id: id,
            emotion: emotion?.rawValue ?? -1,
            contents: contents.map { $0.toDTO() },
            date: date,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
}

public extension DiaryContent {
    func toDTO()-> DiaryContentDTO {
        return .init(id: id, type: type, orderIdx: orderIdx, text: text, image: image?.toDTO())
    }
}

public extension DiaryImage {
    func toDTO()-> DiaryPhotoDTO {
        return .init(id: id, path: path, width: width, height: height)
    }
}

public struct DiaryContent {
    public let id: UUID
    public let type: String
    public let text: String?
    public let orderIdx: Int
    public let image: DiaryImage?
    
    public init(id: UUID, type: String, text: String?, orderIdx: Int, image: DiaryImage?) {
        self.id = id
        self.type = type
        self.text = text
        self.orderIdx = orderIdx
        self.image = image
    }
}

public struct DiaryImage {
    public let id: UUID
    public let width: Double
    public let height: Double
    public let path: String
    
    public init(id: UUID, width: Double, height: Double, path: String) {
        self.id = id
        self.width = width
        self.height = height
        self.path = path
    }
}

public extension DiaryStorageDTO {
    func toDomain() -> Diaries {
        return .init(currentPage: page, totalPages: totalPage, diaries: diaries.map { $0.toDomain() })
    }
}

public extension DiaryDTO {
    func toDomain()-> Diary {
        return .init(id: id, emotion: Emotion(rawValue: emotion), contents: contents.map { $0.toDomain() }, date: date, createdAt: createdAt, updatedAt: updatedAt)
    }
}

public extension DiaryContentDTO {
    func toDomain()-> DiaryContent {
        return .init(id: id, type: type, text: text, orderIdx: orderIdx, image: image?.toDomain())
    }
}

public extension DiaryPhotoDTO {
    func toDomain()-> DiaryImage {
        return .init(id: id, width: width, height: height, path: path)
    }
}
