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
    name: "Feature\(Module.Feature.history.rawValue)",
    targets: [
        .feature(
            interfaces: .history,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interfaces: .diary)
                ]
            )
        ),
        .feature(
            implements: .history,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .history)
                ]
            )
        ),
        .feature(
            testing: .history,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .history)
                ]
            )
        ),
        .feature(
            tests: .history,
            factory: .init(
                dependencies: [
                    .feature(implements: .history),
                    .feature(testing: .history)
                ]
            )
        ),
        .feature(
            example: .history,
            factory: .init(
                dependencies: [
                    .feature(implements: .history)
                ]
            )
        )
    ]
)
