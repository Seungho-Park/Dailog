//
//  SplashStore.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import ComposableArchitecture
import SharedUIInterfaces

public enum SplashState: Equatable {
    case hi
    case dd
    
    public init() {
        self = .hi
    }
}

public enum SplashAction {
    case action
}

public protocol SplashStore: DailogStore where State == SplashState, Action == SplashAction {
    
}
