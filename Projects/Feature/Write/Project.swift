//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/17/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Feature\(Module.Feature.write.rawValue)",
    targets: [
        .feature(
            interfaces: .write,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .write,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .write)
                ]
            )
        ),
        .feature(
            testing: .write,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .write)
                ]
            )
        ),
        .feature(
            tests: .write,
            factory: .init(
                dependencies: [
                    .feature(implements: .write),
                    .feature(testing: .write)
                ]
            )
        ),
        .feature(example: .write, factory: .init(dependencies: [.feature(implements: .write)]))
    ]
)
