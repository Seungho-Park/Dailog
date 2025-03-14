//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/14/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Domain\(Module.Domain.home.rawValue)",
    targets: [
        .domain(interfaces: .home, factory: .init(dependencies: [.core])),
        .domain(implements: .home, factory: .init(dependencies: [.domain(interfaces: .home)])),
        .domain(testing: .home, factory: .init(dependencies: [.domain(interfaces: .home)])),
        .domain(tests: .home, factory: .init(dependencies: [.domain(implements: .home), .domain(testing: .home)]))
    ]
)
