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

final class AppDIContainer {
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
                historySceneDIContainer: makeHistorySceneDIContainer
            )
        )
    }
    
    private func makeHomeSceneDIContainer()-> any DIContainer {
        return DefaultHomeSceneDIContainer()
    }
    
    private func makeHistorySceneDIContainer()-> any DIContainer {
        return DefaultHistorySceneDIContainer()
    }
}
