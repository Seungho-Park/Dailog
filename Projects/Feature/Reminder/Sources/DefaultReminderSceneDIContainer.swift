//
//  DefaultReminderSceneDIContainer.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureReminderInterfaces
import SharedUIInterfaces

public final class DefaultReminderSceneDIContainer: ReminderSceneDIContainer {
    public init() {  }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultReminderSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
    
    public func makeReminderViewModel() -> any ReminderViewModel {
        return DefaultReminderViewModel()
    }
}
