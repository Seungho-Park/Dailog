//
//  DefaultSplashSceneFlowCoordinator.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSplashInterfaces

public final class DefaultSplashSceneFlowCoordinator: SplashSceneFlowCoordinator {
    public let dependencies: SplashSceneFlowCoordinatorDependencies
    public let navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: SplashSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start()-> UIViewController {
        return transition(
            scene: SplashScene.splash(
                dependencies.makeSplashViewModel(
                    action: .init(
                        showMainScene: showMainScene,
                        showLoginScene: showLoginScene
                    )
                )
            ),
            transitionStyle: .root,
            animated: false
        )
    }
    
    public func showMainScene() {
        let diContainer = dependencies.makeMainSceneDIContainer()
        let coordinator = diContainer.makeCoordinator(navController: navigationController)
        coordinator.start()
    }
    
    public func showLoginScene() {
        print("ShowLoginScene")
    }
}
