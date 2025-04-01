//
//  SettingsSceneFlowCoordinator.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import FeaturePinCodeInterfaces
import UIKit

public protocol SettingsSceneFlowCoordinatorDependencies {
    func makePinCodeSceneCoordinator(navigationController: UINavigationController)-> PinCodeSceneFlowCoordinator
    func makeSettingsViewModel(actions: SettingsViewModelAction)-> any SettingsViewModel
}

public protocol SettingsSceneFlowCoordinator: Coordinator {
    var dependencies: SettingsSceneFlowCoordinatorDependencies { get }
}
