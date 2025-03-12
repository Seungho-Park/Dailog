//
//  MainSceneFlowCoordinator.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public protocol MainSceneFlowCoordinatorDependencies {
    func makeHomeSceneDIContainer()-> any DIContainer
    func makeHistorySceneDIContainer()-> any DIContainer
    
    func makeMainViewModel()-> any MainViewModel
}

public protocol MainSceneFlowCoordinator: Coordinator {
    var dependencies: MainSceneFlowCoordinatorDependencies { get }
}
