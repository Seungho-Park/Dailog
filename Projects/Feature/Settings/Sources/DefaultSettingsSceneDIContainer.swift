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

public final class DefaultSettingsSceneDIContainer: SettingsSceneDIContainer {
    
    public init() {  }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultSettingsSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
    
    public func makeSettingsViewModel() -> any SettingsViewModel {
        return DefaultSettingsViewModel()
    }
}
