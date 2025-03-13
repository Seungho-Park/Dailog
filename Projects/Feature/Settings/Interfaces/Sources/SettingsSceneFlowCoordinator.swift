//
//  SettingsSceneFlowCoordinator.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public protocol SettingsSceneFlowCoordinatorDependencies {
    func makeSettingsViewModel()-> any SettingsViewModel
}

public protocol SettingsSceneFlowCoordinator: Coordinator {
    var dependencies: SettingsSceneFlowCoordinatorDependencies { get }
}
