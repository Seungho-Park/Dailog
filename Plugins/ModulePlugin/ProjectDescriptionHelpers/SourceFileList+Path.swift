//
//  SourceFileList+Path.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension ProjectDescription.SourceFilesList {
    static let example: SourceFilesList = "Example/Sources/**"
    static let tests: SourceFilesList = "Tests/Sources/**"
    static let testing: SourceFilesList = "Testing/Sources/**"
    static let sources: SourceFilesList = "Sources/**"
    static let interfaces: SourceFilesList = "Interfaces/Sources/**"
}
