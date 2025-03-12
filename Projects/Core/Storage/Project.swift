//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/12/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project: Project = .makeProject(
    name: "Core\(Module.Core.storage.rawValue)",
    targets: [
        .core(
            interfaces: .storage, factory: .init(
                dependencies: [
                    .shared
                ]
            )
        ),
        .core(
            implements: .storage,
            factory: .init(
                resources: "Resources/**",
                dependencies: [
                    .core(interfaces: .storage)
                ]
            )
        )
    ]
)
