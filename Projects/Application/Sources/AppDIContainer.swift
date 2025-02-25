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
                homeSceneDIContainer: makeHomeSceneDIContainer
            )
        )
    }
    
    private func makeHomeSceneDIContainer()-> any DIContainer {
        return DefaultHomeSceneDIContainer()
    }
}
