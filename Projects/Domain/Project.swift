//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project: Project = .makeProject(
    name: "Domain",
    targets: [
        .domain(
            .init(
                dependencies: [
                    .core,
                    .domain(implements: .home),
                    .domain(implements: .write),
                    .domain(implements: .photo)
                ]
            )
        )
    ]
)
