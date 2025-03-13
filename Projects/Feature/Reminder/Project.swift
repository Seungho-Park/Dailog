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
    name: "Feature\(Module.Feature.reminder.rawValue)",
    targets: [
        .feature(
            interfaces: .reminder,
            factory: .init(
                dependencies: [.domain]
            )
        ),
        .feature(
            implements: .reminder,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .reminder)
                ]
            )
        ),
        .feature(
            testing: .reminder,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .reminder)
                ]
            )
        ),
        .feature(
            tests: .reminder,
            factory: .init(
                dependencies: [
                    .feature(implements: .reminder),
                    .feature(testing: .reminder)
                ]
            )
        ),
        .feature(
            example: .reminder,
            factory: .init(
                dependencies: [
                    .feature(implements: .reminder)
                ]
            )
        )
    ]
)
