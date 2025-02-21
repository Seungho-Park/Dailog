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
    name: "Feature\(Module.Feature.home.rawValue)",
    targets: [
        .feature(
            interfaces: .home,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .home,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .home)
                ]
            )
        ),
        .feature(
            testing: .home,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .home)
                ]
            )
        ),
        .feature(
            tests: .home,
            factory: .init(
                dependencies: [
                    .feature(implements: .home),
                    .feature(testing: .home)
                ]
            )
        ),
        .feature(
            example: .home,
            factory: .init(
                dependencies: [
                    .feature(implements: .home)
                ]
            )
        )
    ]
)
