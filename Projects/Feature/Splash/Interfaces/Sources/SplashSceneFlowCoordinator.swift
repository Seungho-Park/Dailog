//
//  SplashSceneFlowCoordinator.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureMainInterfaces

public protocol SplashSceneFlowCoordinatorDependencies {
    func makeMainSceneFlowCoordinator(navigationController: UINavigationController)-> MainSceneFlowCoordinator
    func makeSplashViewModel(action: SplashViewModelAction)-> any SplashViewModel
}

public protocol SplashSceneFlowCoordinator: Coordinator {
    
    var dependencies: SplashSceneFlowCoordinatorDependencies { get }
    
    func showMainScene()
    func showLoginScene()
}
