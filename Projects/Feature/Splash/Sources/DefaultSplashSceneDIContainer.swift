//
//  DefaultSplashSceneDIContainer.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSplashInterfaces

public final class DefaultSplashSceneDIContainer: SplashSceneDIContainer {
    public init() {  }
    
    public func makeSplashSceneFlowCoordinator(navController: UINavigationController)-> any SplashSceneFlowCoordinator {
        return DefaultSplashSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
}

extension DefaultSplashSceneDIContainer: SplashSceneFlowCoordinatorDependencies {
    public func makeSplashViewModel() -> any SplashViewModel {
        return DefaultSplashViewModel()
    }
}
