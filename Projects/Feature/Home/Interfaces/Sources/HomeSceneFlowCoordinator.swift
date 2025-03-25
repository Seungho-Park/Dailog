//
//  HomeSceneFlowCoordinator.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureDiaryInterfaces

public protocol HomeSceneFlowCoordinatorDependencies {
    func makeWriteSceneFlowCoordinator(navigationController: UINavigationController)-> DiarySceneFlowCoordinator
    
    func makeHomeViewModel(actions: HomeViewModelAction)-> any HomeViewModel
}

public protocol HomeSceneFlowCoordinator: Coordinator {
    var dependencies: HomeSceneFlowCoordinatorDependencies { get }
}
