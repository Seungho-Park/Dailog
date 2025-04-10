//
//  NewDiary.swift
//  DomainDiary
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces

public struct NewDiaries {
    public let currentPage: Int
    public let totalPages: Int
    public let diaries: [NewDiary]
    
    public init(currentPage: Int, totalPages: Int, diaries: [NewDiary]) {
        self.currentPage = currentPage
        self.totalPages = totalPages
        self.diaries = diaries
    }
}

public struct NewDiary {
    public let id: UUID
    public let emotion: Emotion?
    public let contents: [NewDiary.Content]
    public let thumbnail: NewDiary.Content?
    public let date: Date
    public let createdAt: Date
    public let updatedAt: Date
    
    public init(id: UUID, emotion: Emotion?, contents: [NewDiary.Content], thumbnail: NewDiary.Content?, date: Date, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.emotion = emotion
        self.contents = contents
        self.thumbnail = thumbnail
        self.date = date
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public extension NewDiary {
    struct Content {
        public let id: UUID
        public let type: String
        public let photo: NewPhoto?
        public let text: String
        public let orderIdx: Int
        
        public init(id: UUID, type: String, photo: NewPhoto?, text: String, orderIdx: Int) {
            self.id = id
            self.type = type
            self.photo = photo
            self.text = text
            self.orderIdx = orderIdx
        }
    }
}

public extension NewDiaryDTO {
    func toDomain()-> NewDiaries {
        return .init(currentPage: currentPage, totalPages: totalPage, diaries: diaries.map { $0.toDomain() })
    }
}

public extension NewDiaryDTO.DiaryEntity {
    func toDomain()-> NewDiary {
        return .init(id: id, emotion: Emotion(rawValue: emotion ?? -1), contents: contents.map { $0.toDomain() }, thumbnail: thumbnail?.toDomain(), date: date, createdAt: createdAt, updatedAt: updatedAt)
    }
}

public extension DiaryContentDTO {
    func toDomain()-> NewDiary.Content {
        return .init(id: id, type: type, photo: photo?.toDomain(), text: text, orderIdx: orderIdx)
    }
}
