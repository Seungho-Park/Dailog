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
    name: "Feature\(Module.Feature.diary.rawValue)",
    targets: [
        .feature(
            interfaces: .diary,
            factory: .init(
                dependencies: [
                    .domain,
                    .feature(interfaces: .photo)
                ]
            )
        ),
        .feature(
            implements: .diary,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .diary)
                ]
            )
        ),
        .feature(
            testing: .diary,
            factory: .init(
                dependencies: [
                    .feature(interfaces: .diary)
                ]
            )
        ),
        .feature(
            tests: .diary,
            factory: .init(
                dependencies: [
                    .feature(implements: .diary),
                    .feature(testing: .diary)
                ]
            )
        ),
        .feature(example: .diary, factory: .init(dependencies: [.feature(implements: .diary)]))
    ]
)
