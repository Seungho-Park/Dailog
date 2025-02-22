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
    
    public func start() {
        transition(
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
        print("ShowMainScene")
    }
    
    public func showLoginScene() {
        print("ShowLoginScene")
    }
}
