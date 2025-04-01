//
//  DefaultSettingsSceneFlowCoordinator.swift
//  FeatureSettings
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureSettingsInterfaces

public final class DefaultSettingsSceneFlowCoordinator: SettingsSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let dependencies: any SettingsSceneFlowCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: any SettingsSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return SettingsScene.settings(
            dependencies.makeSettingsViewModel(
                actions: .init(
                    showPinCodeScene: showPinCodeScene(isNew:)
                )
            )
        ).instantiate()
    }
    
    private func showPinCodeScene(isNew: Bool) {
        let coordinator = dependencies.makePinCodeSceneCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
