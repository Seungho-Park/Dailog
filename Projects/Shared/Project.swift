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
    name: "Shared",
    targets: [
        .shared(.init(dependencies: [
            .shared(implements: .ui),
            .shared(implements: .thirdPartyLibs)
        ]))
    ]
)
