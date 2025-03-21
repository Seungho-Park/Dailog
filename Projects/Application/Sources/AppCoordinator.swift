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
    
    
    @discardableResult
    func start()-> UIViewController {
        let diContainer = dependencies.makeSplashSceneDIContainer()
        let coordinator = diContainer.makeSplashSceneFlowCoordinator(navigationController: navigationController)
        return coordinator.start()
    }
}
