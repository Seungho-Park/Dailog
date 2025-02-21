//
//  DefaultSplashStore.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import FeatureSplashInterfaces

public struct DefaultSplashStore: SplashStore {
    public var reduce: Reduce<SplashState, SplashAction> {
        Reduce { state, action in
            
            return .none
        }
    }
}
