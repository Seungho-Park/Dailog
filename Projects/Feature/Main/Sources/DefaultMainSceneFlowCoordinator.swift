//
//  DefaultMainSceneFlowCoordinator.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureMainInterfaces

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
        let homeSceneFlowCoordinator = homeSceneDIContainer.makeCoordinator(navController: navigationController)
        
        
        return transition(
            scene: MainScene.main(
                dependencies.makeMainViewModel(),
                [
                    homeSceneFlowCoordinator.start()
                ]
            ),
            transitionStyle: .root,
            animated: true
        )
    }
}
