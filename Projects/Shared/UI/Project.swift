//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 6/27/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModuleDependencies
import ThirdPartyDependencies

let project = Project.makeProject(
    name: "\(Module.Shared.name)\(Module.Shared.ui.rawValue)",
    targets: [
        .shared(
            interface: .ui,
            factory: .init(
                dependencies: [
                    .SPM.PinLayout,
                    .SPM.FlexLayout
                ]
            )
        ),
        .shared(
            implements: .ui,
            factory: .init(
                resources: ["Resources/**"],
                dependencies: [
                    .shared(interfaces: .ui)
                ]
            )
        )
    ]
)
