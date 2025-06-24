//
//  SourceFilesList+Path.swift
//  ModuleDependencies
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription

public extension SourceFilesList {
    static let sources: SourceFilesList = "Sources/**"
    static let interfaces: SourceFilesList = "Interfaces/Sources/**"
    static let testing: SourceFilesList = "Testing/Sources/**"
    static let tests: SourceFilesList = "Tests/Sources/**"
    static let example: SourceFilesList = "Example/Sources/**"
}
