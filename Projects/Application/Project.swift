//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription
import ProjectDescriptionHelpers
import ModulePlugin

let project: Project = .makeProject(
    name: Project.Environment.appName,
    targets: [
        .application(
            .init(
                infoPlist: "Resources/Info.plist",
                resources: [
                    "Resources/Assets.xcassets",
                    "Resources/LaunchScreen.storyboard",
                    "Resources/InfoPlist.xcstrings"
                ],
                dependencies: [
                    .feature
                ],
                settings: .settings(
                    base: [
                        "INFOPLIST_KEY_CFBundleDisplayName" : "\(Project.Environment.appName)",
                        "CURRENT_PROJECT_VERSION":"1",
                        "MARKETING_VERSION":"1.0.0",
                        "INFOPLIST_KEY_LSApplicationCategoryType":"public.app-category.lifestyle"
                    ]
                )
            )
        )
    ]
)
