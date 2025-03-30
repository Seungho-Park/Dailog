//
//  DefaultReminderSceneFlowCoordinator.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureReminderInterfaces

public final class DefaultReminderSceneFlowCoordinator: ReminderSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let dependencies: any ReminderSceneFlowCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: any ReminderSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return ReminderScene.reminder(dependencies.makeReminderViewModel()).instantiate()
    }
}
