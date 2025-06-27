//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project = Project.makeProject(
    name: "Shared",
    targets: [
        .shared(
            .init(
                dependencies: [
                    .shared(implements: .app)
                ]
            )
        )
    ]
)
