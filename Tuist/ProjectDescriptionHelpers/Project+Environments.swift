//
//  Project+Environments.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription

public extension Project {
    enum Environments {
        public static let appName: String = "Dailog"
        public static let bundleIdentifier: String = "net.devswift.dailog"
        public static let deploymentTarget: DeploymentTargets = .iOS("15.0")
    }
}
