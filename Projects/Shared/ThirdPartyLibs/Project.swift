//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/22/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin
import ThirdPartyLibs

let project: Project = .makeProject(
    name: "Shared\(Module.Shared.thirdPartyLibs.rawValue)",
    targets: [
        .shared(
            implements: .thirdPartyLibs,
            factory: .init(
                dependencies: [
                    .SPM.RxSwift,
                    .SPM.RxRelay
                ]
            )
        )
    ]
)
