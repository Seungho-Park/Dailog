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
        let mainSceneDIContainer: ()-> DIContainer
        
        public init(
            mainSceneDIContainer: @escaping ()-> DIContainer
        ) {
            self.mainSceneDIContainer = mainSceneDIContainer
        }
    }
    
    private let dependencies: Dependencies
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultSplashSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
}

extension DefaultSplashSceneDIContainer: SplashSceneFlowCoordinatorDependencies {
    public func makeMainSceneDIContainer() -> any DIContainer {
        return dependencies.mainSceneDIContainer()
    }
    public func makeSplashViewModel(action: SplashViewModelAction) -> any SplashViewModel {
        return DefaultSplashViewModel(action: action)
    }
}
