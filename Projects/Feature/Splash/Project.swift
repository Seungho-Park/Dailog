//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/20/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project: Project = .makeProject(
    name: "Feature\(Module.Feature.splash.rawValue)",
    targets: [
        .feature(
            interfaces: .splash,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interfaces: .main),
                    .feature(interfaces: .pinCode)
                ]
            )
        ),
        .feature(
            implements: .splash,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .splash)
                ]
            )
        ),
        .feature(
            testing: .splash,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .splash)
                ]
            )
        ),
        .feature(
            tests: .splash,
            factory: .init(
                dependencies: [
                    .feature(implements: .splash),
                    .feature(testing: .splash)
                ]
            )
        ),
        .feature(
            example: .splash,
            factory: .init(
                dependencies: [
                    .feature(implements: .splash)
                ]
            )
        )
    ]
)
