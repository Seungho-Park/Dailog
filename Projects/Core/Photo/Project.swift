//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/20/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Core\(Module.Core.photo.rawValue)",
    targets: [
        .core(interfaces: .photo, factory: .init(dependencies: [
            .shared
        ])),
        .core(implements: .photo, factory: .init(dependencies: [.core(interfaces: .photo)]))
    ]
)
