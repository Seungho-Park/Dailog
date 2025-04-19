//
//  DiaryContentDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryContentDTO {
    public let id: UUID
    public let type: String
    public let orderIdx: Int
    public let text: String?
    public let image: DiaryPhotoDTO?
    
    public init(id: UUID, type: String, orderIdx: Int, text: String?, image: DiaryPhotoDTO?) {
        self.id = id
        self.type = type
        self.orderIdx = orderIdx
        self.text = text
        self.image = image
    }
}
