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
    name: "Domain\(Module.Domain.diary.rawValue)",
    targets: [
        .domain(interfaces: .diary, factory: .init(dependencies: [.core])),
        .domain(implements: .diary, factory: .init(dependencies: [.domain(interfaces: .diary)]))
    ]
)
