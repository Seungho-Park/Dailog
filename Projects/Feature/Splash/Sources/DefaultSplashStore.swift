//
//  DefaultSplashStore.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import AppTrackingTransparency
import AdSupport
import ComposableArchitecture
import FeatureSplashInterfaces

public struct DefaultSplashStore: SplashStore {
    public init() {  }
    public var reduce: Reduce<SplashState, SplashAction> {
        Reduce { state, action in
            switch action {
            case .didAppear:
                return .send(.requestAppTrackingAuthorization)
            case .requestAppTrackingAuthorization:
                return Effect.run { send in
                    await requestAppTrackingAuthorization()
                    await send(.requestPushNotificationPermission)
                }
            case .requestPushNotificationPermission:
                return Effect.run { send in
                    await requestPushNotificationAuthorization()
                    await send(.showMainScene)
                }
            case .showMainScene:
                return .none
            }
        }
    }
    
    @MainActor
    @discardableResult
    private func requestPushNotificationAuthorization() async -> Bool {
        (try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])) ?? false
    }
    
    @MainActor
    @discardableResult
    private func requestAppTrackingAuthorization() async -> UUID? {
        let auth = await ATTrackingManager.requestTrackingAuthorization()
        
        switch auth {
        case .authorized: return ASIdentifierManager.shared().advertisingIdentifier
        default: return nil
        }
    }
}
