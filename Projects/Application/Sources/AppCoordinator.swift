//
//  AppCoordinator.swift
//  Dailog
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

final class AppCoordinator: Coordinator {
    private let dependencies: AppDIContainer
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: AppDIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let diContainer = dependencies.makeSplashSceneDIContainer()
        let coordinator = diContainer.makeSplashSceneFlowCoordinator(navController: navigationController)
        coordinator.start()
    }
}
