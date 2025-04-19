//
//  DiaryStorageDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public struct DiaryStorageDTO {
    public let page: Int
    public let totalPage: Int
    public let diaries: [DiaryDTO]
    
    public init(page: Int, totalPage: Int, diaries: [DiaryDTO]) {
        self.page = page
        self.totalPage = totalPage
        self.diaries = diaries
    }
}
