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
    case load
    case appear
    case notRegistered
    case authorized
    
    public init() {
        self = .load
    }
}

public enum SplashAction: Equatable {
    case didAppear
    case requestAppTrackingAuthorization
    case requestPushNotificationPermission
    case showMainScene
}

public protocol SplashStore: DailogStore where State == SplashState, Action == SplashAction {
    
}
