//
//  DefaultHomeSceneFlowCoordinator.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureHomeInterfaces

public final class DefaultHomeSceneFlowCoordinator: HomeSceneFlowCoordinator {
    public var dependencies: any FeatureHomeInterfaces.HomeSceneFlowCoordinatorDependencies
    
    public init(
        navigationController: UINavigationController,
        dependencies: any HomeSceneFlowCoordinatorDependencies
    ) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    public var navigationController: UINavigationController
    
    public func start() -> UIViewController {
        return HomeScene.home(
            dependencies.makeHomeViewModel(
                actions: .init(
                    showWriteScene: showWriteDiaryScene
                )
            )
        ).instantiate()
    }
    
    private func showWriteDiaryScene() {
        let coordinator = dependencies.makeWriteSceneFlowCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
