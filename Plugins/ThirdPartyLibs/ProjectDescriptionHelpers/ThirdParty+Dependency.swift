//
//  ThirdParty+Dependency.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension ProjectDescription.TargetDependency {
    enum SPM {
        public static let TCA: TargetDependency = .external(name: "ComposableArchitecture")
    }
}
