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
    name: "Feature",
    targets: [
        .feature(
            .init(
                dependencies: [
                    .domain,
                    .feature(implements: .splash),
                    .feature(implements: .main),
                    .feature(implements: .home),
                    .feature(implements: .calendar),
                    .feature(implements: .settings)
                ]
            )
        )
    ]
)
