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
import FeatureHistoryInterfaces
import FeatureReminderInterfaces
import FeatureSettingsInterfaces

public final class DefaultMainSceneDIContainer: MainSceneDIContainer {
    public let dependencies: MainSceneDIContainerDependencies
    
    public init(dependencies: MainSceneDIContainerDependencies) {
        self.dependencies = dependencies
    }
    
    public func makeMainSceneFlowCoordinator(navigationController: UINavigationController)-> MainSceneFlowCoordinator {
        return DefaultMainSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DefaultMainSceneDIContainer: MainSceneFlowCoordinatorDependencies {
    public func makeHomeSceneDIContainer() -> HomeSceneDIContainer {
        return dependencies.homeSceneDIContainer
    }
    
    public func makeHistorySceneDIContainer() -> HistorySceneDIContainer {
        return dependencies.historySceneDIContainer
    }
    
    public func makeReminderSceneDIContainer() -> ReminderSceneDIContainer {
        return dependencies.reminderSceneDIContainer
    }
    
    public func makeSettingsSceneDIContainer() -> SettingsSceneDIContainer {
        return dependencies.settingsSceneDIContainer
    }
    
    public func makeMainViewModel() -> any MainViewModel {
        return DefaultMainViewModel()
    }
}
