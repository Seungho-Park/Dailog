//
//  ReminderSceneFlowCoordinator.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public protocol ReminderSceneFlowCoordinatorDependencies {
    func makeReminderViewModel()-> any ReminderViewModel
}

public protocol ReminderSceneFlowCoordinator: Coordinator {
    var dependencies: ReminderSceneFlowCoordinatorDependencies { get }
}
