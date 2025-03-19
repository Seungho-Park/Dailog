//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 3/19/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project = Project.makeProject(
    name: "Feature\(Module.Feature.photo.rawValue)",
    targets: [
        .feature(interfaces: .photo, factory: .init(dependencies: [.domain])),
        .feature(implements: .photo, factory: .init(dependencies: [.feature(interfaces: .photo)]))
    ]
)
