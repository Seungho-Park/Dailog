//
//  AdviceList.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public struct AdviceList: Decodable {
    public let advices: [Advice]
}

public extension AdviceList {
    struct Advice: Decodable {
        public let id: Int
        public let translation: [String: Translation]
    }
}

public extension AdviceList.Advice {
    struct Translation: Decodable {
        public let text: String
        public let author: Author
        
        public init(text: String, author: Author) {
            self.text = text
            self.author = author
        }
    }
}

public extension AdviceList.Advice.Translation {
    struct Author: Decodable {
        public let name: String
        public let description: String
        
        public init(name: String, description: String) {
            self.name = name
            self.description = description
        }
    }
}
