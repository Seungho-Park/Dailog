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
    name: "Feature\(Module.Feature.calendar.rawValue)",
    targets: [
        .feature(
            interfaces: .calendar,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .calendar,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .calendar)
                ]
            )
        ),
        .feature(
            testing: .calendar,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .calendar)
                ]
            )
        ),
        .feature(
            tests: .calendar,
            factory: .init(
                dependencies: [
                    .feature(implements: .calendar),
                    .feature(testing: .calendar)
                ]
            )
        ),
        .feature(
            example: .calendar,
            factory: .init(
                dependencies: [
                    .feature(implements: .calendar)
                ]
            )
        )
    ]
)
