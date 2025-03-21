//
//  DefaultSplashSceneDIContainer.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSplashInterfaces
import FeatureMainInterfaces
import SharedUIInterfaces

public final class DefaultSplashSceneDIContainer: SplashSceneDIContainer {
    public struct Dependencies {
        let mainSceneDIContainer: MainSceneDIContainer
        
        public init(
            mainSceneDIContainer: MainSceneDIContainer
        ) {
            self.mainSceneDIContainer = mainSceneDIContainer
        }
    }
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func makeSplashSceneFlowCoordinator(navigationController: UINavigationController)-> SplashSceneFlowCoordinator {
        return DefaultSplashSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DefaultSplashSceneDIContainer: SplashSceneFlowCoordinatorDependencies {
    public func makeMainSceneFlowCoordinator(navigationController: UINavigationController) -> any MainSceneFlowCoordinator {
        return dependencies.mainSceneDIContainer.makeMainSceneFlowCoordinator(navigationController: navigationController)
    }
    public func makeSplashViewModel(action: SplashViewModelAction) -> any SplashViewModel {
        return DefaultSplashViewModel(action: action)
    }
}
