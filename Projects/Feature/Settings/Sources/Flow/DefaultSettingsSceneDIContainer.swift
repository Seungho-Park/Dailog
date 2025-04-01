//
//  DefaultSettingsSceneDIContainer.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSettingsInterfaces
import SharedUIInterfaces
import FeaturePinCodeInterfaces

public final class DefaultSettingsSceneDIContainer: SettingsSceneDIContainer {
    public let dependencies: SettingsSceneDIContainerDependencies
    
    public init(
        dependencies: SettingsSceneDIContainerDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makeSettingsSceneFlowCoordinator(navigationController: UINavigationController)-> SettingsSceneFlowCoordinator {
        return DefaultSettingsSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    public func makeSettingsViewModel(actions: SettingsViewModelAction) -> any SettingsViewModel {
        return DefaultSettingsViewModel(actions: actions)
    }
    
    public func makePinCodeSceneCoordinator(navigationController: UINavigationController) -> any PinCodeSceneFlowCoordinator {
        dependencies.pinCodeSceneDIContainer().makePinCodeSceneFlowCoordinator(navigationController: navigationController)
    }
}
