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
    name: "Feature",
    targets: [
        .feature(
            .init(
                dependencies: [
                    .domain,
                    .feature(implements: .home),
                    .feature(implements: .history)
                ]
            )
        )
    ]
)
