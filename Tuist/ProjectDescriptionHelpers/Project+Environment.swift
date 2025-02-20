//
//  Environment.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension Project {
    enum Environment {
        public static let appName: String = "Dailog"
        public static let organizationName: String = "DevLabs Co."
        public static let deploymentTarget: DeploymentTargets = .iOS("16.0")
        public static let bundleId: String = "net.devswift.dailog"
    }
}
