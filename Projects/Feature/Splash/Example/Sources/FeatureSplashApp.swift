//
//  FeatureSplashApp.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import SharedUI
import FeatureSplash
import FeatureSplashInterfaces

@main
struct FeatureSplashApp: App {
    var body: some Scene {
        UIAppearance.setup()
        return WindowGroup {
            SplashView<DefaultSplashStore>(store: .init(initialState: DefaultSplashStore.State.appear, reducer: { DefaultSplashStore().reduce }))
        }
    }
}
