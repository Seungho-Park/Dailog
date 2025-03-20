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
    name: "Domain\(Module.Domain.photo.rawValue)",
    targets: [
        .domain(interfaces: .photo, factory: .init(dependencies: [.core])),
        .domain(implements: .photo, factory: .init(dependencies: [.domain(interfaces: .photo)]))
    ]
)
