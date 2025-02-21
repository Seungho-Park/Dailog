//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/22/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Feature\(Module.Feature.settings.rawValue)",
    targets: [
        .feature(
            interfaces: .settings,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .settings,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .settings)
                ]
            )
        ),
        .feature(
            testing: .settings,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .settings)
                ]
            )
        ),
        .feature(
            tests: .settings,
            factory: .init(
                dependencies: [
                    .feature(implements: .settings),
                    .feature(testing: .settings)
                ]
            )
        ),
        .feature(
            example: .settings,
            factory: .init(
                dependencies: [
                    .feature(implements: .settings)
                ]
            )
        )
    ]
)
