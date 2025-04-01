//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 4/2/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Feature\(Module.Feature.pinCode.rawValue)",
    targets: [
        .feature(
            interfaces: .pinCode,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .pinCode,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .pinCode)
                ]
            )
        ),
        .feature(
            testing: .pinCode,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .pinCode)
                ]
            )
        ),
        .feature(
            tests: .pinCode,
            factory: .init(
                dependencies: [
                    .feature(implements: .pinCode),
                    .feature(testing: .pinCode)
                ]
            )
        ),
        .feature(
            example: .pinCode,
            factory: .init(
                dependencies: [
                    .feature(implements: .pinCode)
                ]
            )
        )
    ]
)
