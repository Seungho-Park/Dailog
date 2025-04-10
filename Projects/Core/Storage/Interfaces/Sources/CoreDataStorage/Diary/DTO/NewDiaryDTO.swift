//
//  NewDiaryDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import Foundation

public struct NewDiaryDTO {
    public let currentPage: Int
    public let totalPage: Int
    public let count: Int
    public let diaries: [NewDiaryDTO.DiaryEntity]
    
    public init(currentPage: Int, totalPage: Int, count: Int, diaries: [NewDiaryDTO.DiaryEntity]) {
        self.currentPage = currentPage
        self.totalPage = totalPage
        self.count = count
        self.diaries = diaries
    }
}

public extension NewDiaryDTO {
    struct DiaryEntity {
        public let id: UUID
        public let emotion: Int16?
        public let contents: [DiaryContentDTO]
        public let thumbnail: DiaryContentDTO?
        public let date: Date
        public let createdAt: Date
        public let updatedAt: Date
        
        public init(id: UUID, emotion: Int16?, contents: [DiaryContentDTO], thumbnail: DiaryContentDTO?, date: Date, createdAt: Date, updatedAt: Date) {
            self.id = id
            self.emotion = emotion
            self.contents = contents
            self.thumbnail = thumbnail
            self.date = date
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
}
