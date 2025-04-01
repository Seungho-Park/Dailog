//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin
import ThirdPartyLibs

let project: Project = .makeProject(
    name: "Shared\(Module.Shared.ui.rawValue)",
    targets: [
        .shared(
            interfaces: .ui,
            factory: .init(
                dependencies: [
                    .SPM.FlexLayout,
                    .SPM.PinLayout,
                    .SPM.RxCocoa,
                    .SPM.RxSwift,
                    .SPM.RxRelay,
                    .SPM.Charts
                ]
            )
        ),
        .shared(
            implements: .ui,
            factory: .init(
                infoPlist: .extendingDefault(with: ["UIAppFonts" : ["Jalnan2.otf"]]),
                resources: "Resources/**",
                dependencies: [
                    .shared(interfaces: .ui)
                ]
            )
        )
    ]
)
