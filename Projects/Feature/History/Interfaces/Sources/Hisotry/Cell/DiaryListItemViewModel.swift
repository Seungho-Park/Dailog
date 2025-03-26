//
//  DiaryListItemViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/26/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public struct DiaryListItemViewModel {
    public let id: UUID
    public let content: String
    public let date: Date
    public let thumbnail: Thumbnail?
    
    public init(id: UUID, content: String, date: Date, thumbnail: Thumbnail?) {
        self.id = id
        self.content = content
        self.date = date
        self.thumbnail = thumbnail
    }
}

public extension DiaryListItemViewModel {
    struct Thumbnail {
        public let image: Data
        public let hasMultiple: Bool
        
        public init(image: Data, hasMultiple: Bool) {
            self.image = image
            self.hasMultiple = hasMultiple
        }
    }
}
