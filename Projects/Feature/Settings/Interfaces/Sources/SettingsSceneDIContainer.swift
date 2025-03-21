//
//  SettingsSceneDIContainer.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public protocol SettingsSceneDIContainer: SettingsSceneFlowCoordinatorDependencies {
    func makeSettingsSceneFlowCoordinator(navigationController: UINavigationController)-> SettingsSceneFlowCoordinator
}
