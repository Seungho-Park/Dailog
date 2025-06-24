//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies

let project = Project.makeProject(
    name: "\(Module.Core.name)\(Module.Core.storage.rawValue)",
    targets: [
        .core(
            interface: .storage,
            factory: .init(
                dependencies: [
                    .shared
                ],
                coreDataModels: [
                    .coreDataModel("Interfaces/Sources/CoreDataStorage.xcdatamodeld")
                ]
            )
        ),
        .core(
            implements: .storage,
            factory: .init(
                dependencies: [
                    .core(interfaces: .storage)
                ]
            )
        )
    ]
)
