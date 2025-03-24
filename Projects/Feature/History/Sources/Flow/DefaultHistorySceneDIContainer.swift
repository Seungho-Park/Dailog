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
    
    public func makeHistorySceneFlowCoordinator(navigationController: UINavigationController) -> HistorySceneFlowCoordinator {
        return DefaultHistorySceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DefaultHistorySceneDIContainer {
    public func makeHistoryViewModel(actions: HistoryViewModelAction) -> any HistoryViewModel {
        return DefaultHistoryViewModel(actions: actions)
    }
    
    public func makeHistoryFilterViewModel(actions: HistoryFilterViewModelAction) -> any HistoryFilterViewModel {
        return DefaultHistoryFilterViewModel(actions: actions)
    }
}
