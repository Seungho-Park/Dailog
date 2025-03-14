//
//  AppDIContainer.swift
//  Dailog
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import UIKit
import FeatureSplash
import FeatureMain
import FeatureHome
import FeatureHistory
import SharedUIInterfaces
import FeatureReminder
import FeatureSettings

final class AppDIContainer {
    private let config = ApplicationConfig()
    
    func makeSplashSceneDIContainer()-> any DIContainer {
        return DefaultSplashSceneDIContainer(
            dependencies: .init(
                mainSceneDIContainer: makeMainSceneDIContainer
            )
        )
    }
    
    private func makeMainSceneDIContainer()-> any DIContainer {
        return DefaultMainSceneDIContainer(
            dependencies: .init(
                homeSceneDIContainer: makeHomeSceneDIContainer,
                historySceneDIContainer: makeHistorySceneDIContainer,
                reminderSceneDIContainer: makeReminderSceneDIContainer,
                settingsSceneDIContainer: makeSettingsSceneDIContainer
            )
        )
    }
    
    private func makeHomeSceneDIContainer()-> any DIContainer {
        return DefaultHomeSceneDIContainer(dependencies: .init())
    }
    
    private func makeHistorySceneDIContainer()-> any DIContainer {
        return DefaultHistorySceneDIContainer()
    }
    
    private func makeReminderSceneDIContainer()-> any DIContainer {
        return DefaultReminderSceneDIContainer()
    }
    
    private func makeSettingsSceneDIContainer()-> any DIContainer {
        return DefaultSettingsSceneDIContainer()
    }
}
