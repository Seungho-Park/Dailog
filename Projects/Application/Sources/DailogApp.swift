//
//  AppDependency.swift
//  Dailog
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import SharedUI
import SharedUIInterfaces
import FeatureSplash

@main
struct DailogApp: App {
    var body: some Scene {
        UIAppearance.setup()
        return WindowGroup {
            SplashView()
        }
    }
}
