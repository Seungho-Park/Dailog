//
//  DiaryPhotoDTO.swift
//  CoreStorage
//
//  Created by 박승호 on 4/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryPhotoDTO {
    public let id: UUID
    public let path: String
    public let width: Double
    public let height: Double
    
    public init(id: UUID, path: String, width: Double, height: Double) {
        self.id = id
        self.path = path
        self.width = width
        self.height = height
    }
}
