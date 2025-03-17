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
    name: "Domain\(Module.Domain.write.rawValue)",
    targets: [
        .domain(interfaces: .write, factory: .init(dependencies: [.core])),
        .domain(implements: .write, factory: .init(dependencies: [.domain(interfaces: .write)]))
    ]
)
