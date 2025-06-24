//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Project.Environments.appName,
    targets: [
        .application(
            .init(
                dependencies: [
                    .feature
                ]
            )
        )
    ]
)
