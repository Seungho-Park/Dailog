//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/13/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Feature\(Module.Feature.login.rawValue)",
    targets: [
        .feature(
            interfaces: .login,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .login,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .login)
                ]
            )
        ),
        .feature(
            testing: .login,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .login)
                ]
            )
        ),
        .feature(
            tests: .login,
            factory: .init(
                dependencies: [
                    .feature(implements: .login),
                    .feature(testing: .login)
                ]
            )
        ),
        .feature(
            example: .login,
            factory: .init(
                dependencies: [
                    .feature(implements: .login)
                ]
            )
        )
    ]
)
