//
//  SettingsSceneDIContainer.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeaturePinCodeInterfaces

public struct SettingsSceneDIContainerDependencies {
    public let pinCodeSceneDIContainer: ()-> PinCodeSceneDIContainer
    
    public init(pinCodeSceneDIContainer: @escaping () -> PinCodeSceneDIContainer) {
        self.pinCodeSceneDIContainer = pinCodeSceneDIContainer
    }
}

public protocol SettingsSceneDIContainer: SettingsSceneFlowCoordinatorDependencies {
    var dependencies: SettingsSceneDIContainerDependencies { get }
    
    func makeSettingsSceneFlowCoordinator(navigationController: UINavigationController)-> SettingsSceneFlowCoordinator
}
