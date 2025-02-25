//
//  DefaultMainSceneDIContainer.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureMainInterfaces
import FeatureHomeInterfaces
import SharedUIInterfaces

public final class DefaultMainSceneDIContainer: MainSceneDIContainer {
    public struct Dependencies {
        public let homeSceneDIContainer: ()-> any DIContainer
        
        public init(homeSceneDIContainer: @escaping () -> any DIContainer) {
            self.homeSceneDIContainer = homeSceneDIContainer
        }
    }
    
    private let dependencies: Dependencies
    
    
    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultMainSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
}

extension DefaultMainSceneDIContainer: MainSceneFlowCoordinatorDependencies {
    public func makeHomeSceneDIContainer() -> any DIContainer {
        return dependencies.homeSceneDIContainer()
    }
    
    public func makeMainViewModel() -> any MainViewModel {
        return DefaultMainViewModel()
    }
}
