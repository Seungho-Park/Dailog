//
//  DefaultHistorySceneDIContainer.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureHistoryInterfaces

public final class DefaultHistorySceneDIContainer: HistorySceneDIContainer {
    
    public init() {
        
    }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultHistorySceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
}
