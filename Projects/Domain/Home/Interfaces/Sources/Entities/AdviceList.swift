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
    }
}

public extension AdviceList.Advice.Translation {
    struct Author: Decodable {
        public let name: String
        public let description: String
    }
}
