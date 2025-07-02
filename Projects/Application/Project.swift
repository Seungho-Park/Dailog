//
//  Project.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project: Project = .makeProject(
    name: Project.Environments.appName,
    targets: [
        .application(
            .init(
                infoPlist: "Resources/Info.plist",
                resources: [
                    .glob(
                        pattern: "Resources/**",
                        excluding: [
                            "Resources/**/Info.plist"
                        ],
                        tags: [],
                        inclusionCondition: nil
                    )
                ],
                scripts: [
                    // MARK: - Needle
                    .pre(
                        script: """
                            export PATH="$PATH:/opt/homebrew/bin"
                                                    
                            if which needle; then
                                echo "Generate Needle Dependencies..."
                                needle generate $SRCROOT/Sources/Generated/NeedleGenerated.swift $SRCROOT/../
                            else
                                echo "Needle not installed. Skipping code generation."
                            fi
                        """,
                        name: "Needle Generator",
                        outputPaths: [
                            "$(SRCROOT)/Sources/Generated/NeedleGenerated.swift"
                        ],
                        basedOnDependencyAnalysis: false
                    ),
                    // MARK: - Firebase Crashlytics
                    .post(
                        path: .relativeToRoot("Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"),
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
                        "OTHER_LDFLAGS": [
                            "$(inherited) -ObjC"
                        ],
                        "DEBUG_INFORMATION_FORMAT":"dwarf-with-dsym",
                        "INFOPLIST_KEY_LSApplicationCategoryType": "public.app-category.lifestyle",
                        "MARKETING_VERSION": "1.0.0",
                        "CURRENT_PROJECT_VERSION": "1",
                        "INFOPLIST_KEY_CFBundleDisplayName": "\(Project.Environments.appName)"
                    ],
                    configurations: []
                )
            )
        )
    ]
)
