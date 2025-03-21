//
//  DefaultMainSceneFlowCoordinator.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureMainInterfaces
import SharedUIInterfaces
import SharedUI

public final class DefaultMainSceneFlowCoordinator: MainSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let dependencies: any MainSceneFlowCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: any MainSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start()-> UIViewController {
        let homeSceneDIContainer = dependencies.makeHomeSceneDIContainer()
        let homeSceneFlowCoordinator = homeSceneDIContainer.makeHomeSceneFlowCoordinator(navigationController: navigationController)
        
        let historySceneDIContainer = dependencies.makeHistorySceneDIContainer()
        let historySceneFlowCoordinator = historySceneDIContainer.makeHistorySceneFlowCoordinator(navigationController: navigationController)
        
        let reminderSceneDIContainer = dependencies.makeReminderSceneDIContainer()
        let reminderSceneFlowCoordinator = reminderSceneDIContainer.makeReminderSceneFlowCoordinator(navigationController: navigationController)
        
        let settingsSceneDIContainer = dependencies.makeSettingsSceneDIContainer()
        let settingsSceneFlowCoordinator = settingsSceneDIContainer.makeSettingsSceneFlowCoordinator(navigationController: navigationController)
        
        let viewControllers = [
            homeSceneFlowCoordinator.start(),
            historySceneFlowCoordinator.start(),
            reminderSceneFlowCoordinator.start(),
            settingsSceneFlowCoordinator.start()
        ]
        
        return transition(
            scene: MainScene.main(
                dependencies.makeMainViewModel(),
                viewControllers
            ),
            transitionStyle: .root,
            animated: false
        )
    }
}
