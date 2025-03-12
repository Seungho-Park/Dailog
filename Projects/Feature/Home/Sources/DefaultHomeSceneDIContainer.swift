//
//  DefaultHomeSceneDIContainer.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureHomeInterfaces
import SharedUIInterfaces

public final class DefaultHomeSceneDIContainer: HomeSceneDIContainer {
    public init() {  }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultHomeSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
}

extension DefaultHomeSceneDIContainer {
    public func makeHomeViewModel() -> any HomeViewModel {
        return DefaultHomeViewModel()
    }
}
