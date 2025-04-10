//
//  DiaryContentsDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryContentDTO {
    public let id: UUID
    public let type: String
    public let text: String
    public let orderIdx: Int
    public let photo: PhotoDTO?
    
    public init(id: UUID, type: String, text: String, orderIdx: Int, photo: PhotoDTO?) {
        self.id = id
        self.type = type
        self.text = text
        self.orderIdx = orderIdx
        self.photo = photo
    }
}
