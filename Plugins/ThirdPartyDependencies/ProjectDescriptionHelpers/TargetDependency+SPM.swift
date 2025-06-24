//
//  TargetDependency+SPM.swift
//  ModuleDependencies
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription

public extension TargetDependency {
    enum SPM {
        // MARK: - DI
        public static let Needle: TargetDependency = .external(name: "NeedleFoundation")
        
        // MARK: - Firebase
        public static let FirebaseAnalytics: TargetDependency = .external(name: "FirebaseAnalytics")
        public static let FirebaseCrashlytics: TargetDependency = .external(name: "FirebaseCrashlytics")
        public static let FirebaseMessaging: TargetDependency = .external(name: "FirebaseMessaging")
    }
}
