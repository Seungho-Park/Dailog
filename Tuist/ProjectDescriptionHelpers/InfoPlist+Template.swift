//
//  InfoPlist+Template.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension ProjectDescription.InfoPlist {
    static let example: Self = {
        return .dictionary(
            [
                "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
                "CFBundleName": "$(PRODUCT_NAME)",
                "CFBundleDisplayName": "$(PRODUCT_NAME)",
                "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
                "CFBundleInfoDictionaryVersion": "6.0",
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
                "CFBundleExecutable": "$(EXECUTABLE_NAME)",
                "CFBundlePackageType": "$(PRODUCT_BUNDLE_PACKAGE_TYPE)",
                "UILaunchStoryboardName": "LaunchScreen",
                "UIApplicationSceneManifest": [
                    "UIApplicationSupportsMultipleScenes": false,
                    "UISceneConfigurations": [
                        "UIWindowSceneSessionRoleApplication": [
                            [
                                
                            ]
                        ]
                    ]
                ]
            ]
        )
    }()
}
