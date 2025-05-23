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
    name: "Feature\(Module.Feature.main.rawValue)",
    targets: [
        .feature(
            interfaces: .main,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interfaces: .home),
                    .feature(interfaces: .history),
                    .feature(interfaces: .reminder),
                    .feature(interfaces: .settings)
                ]
            )
        ),
        .feature(
            implements: .main,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .main)
                ]
            )
        ),
        .feature(
            testing: .main,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .main)
                ]
            )
        ),
        .feature(
            tests: .main,
            factory: .init(
                dependencies: [
                    .feature(implements: .main),
                    .feature(testing: .main)
                ]
            )
        ),
        .feature(
            example: .main,
            factory: .init(
                dependencies: [
                    .feature(implements: .main)
                ]
            )
        )
    ]
)
