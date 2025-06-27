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
    name: "\(Module.Shared.name)\(Module.Shared.app.rawValue)",
    targets: [
        .shared(
            implements: .app,
            factory: .init(
                dependencies: [
                    .SPM.Needle,
                    .SPM.FirebaseAnalytics,
                    .SPM.FirebaseCrashlytics,
                    .SPM.FirebaseMessaging
                ]
            )
        )
    ]
)
