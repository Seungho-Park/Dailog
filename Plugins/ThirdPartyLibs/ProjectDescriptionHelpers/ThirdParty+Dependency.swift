//
//  ThirdParty+Dependency.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension ProjectDescription.TargetDependency {
    enum SPM {
        public static let RxSwift: TargetDependency = .external(name: "RxSwift")
        public static let FlexLayout: TargetDependency = .external(name: "FlexLayout")
        public static let PinLayout: TargetDependency = .external(name: "PinLayout")
    }
}
