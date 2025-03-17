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
                    "Resources/InfoPlist.xcstrings",
                    "Resources/GoogleService-Info.plist",
                    
                ],
                entitlements: .file(path: "Resources/Dailog.entitlements"),
                scripts: [
                    .post(path: .relativeToRoot("Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"),
                        name: "Firebase Crashlystics",
                        inputPaths: [
                            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}",
                            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${PRODUCT_NAME}",
                            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Info.plist",
                            "$(TARGET_BUILD_DIR)/$(UNLOCALIZED_RESOURCES_FOLDER_PATH)/GoogleService-Info.plist",
                            "$(TARGET_BUILD_DIR)/$(EXECUTABLE_PATH)"
                        ],
                        basedOnDependencyAnalysis: false
                    )
                ],
                dependencies: [
                    .feature
                ],
                settings: .settings(
                    base: [
                        "INFOPLIST_KEY_CFBundleDisplayName" : "\(Project.Environment.appName)",
                        "CURRENT_PROJECT_VERSION":"1",
                        "MARKETING_VERSION":"1.0.0",
                        "INFOPLIST_KEY_LSApplicationCategoryType":"public.app-category.lifestyle",
                        "DEBUG_INFORMATION_FORMAT":"dwarf-with-dsym",
                        "OTHER_LDFLAGS": [
                            "$(inherited) -ObjC"
                        ],
                        "ENABLE_USER_SCRIPT_SANDBOXING": false,
                        "INFOPLIST_KEY_UILaunchStoryboardName":"LaunchScreen"
                    ]
                ),
                launchArguments: [
                    .launchArgument(name: "-FIRDebugDisabled", isEnabled: true)
                ]
            )
        )
    ]
)
