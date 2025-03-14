//
//  Prompts.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public struct Prompts: Decodable {
    public let prompts: [Prompt]
}

public extension Prompts {
    struct Prompt: Decodable {
        public let id: Int
        public let translations: [String: Translation]
    }
}

public extension Prompts.Prompt {
    struct Translation: Codable {
        public let title: String
        public let subtitle: String
        
        public init(title: String, subtitle: String) {
            self.title = title
            self.subtitle = subtitle
        }
    }
}
