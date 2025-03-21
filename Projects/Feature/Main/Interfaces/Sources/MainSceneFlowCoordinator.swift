//
//  MainSceneFlowCoordinator.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureHomeInterfaces
import FeatureHistoryInterfaces
import FeatureReminderInterfaces
import FeatureSettingsInterfaces

public protocol MainSceneFlowCoordinatorDependencies {
    func makeHomeSceneDIContainer()-> HomeSceneDIContainer
    func makeHistorySceneDIContainer()-> HistorySceneDIContainer
    func makeReminderSceneDIContainer()-> ReminderSceneDIContainer
    func makeSettingsSceneDIContainer()-> SettingsSceneDIContainer
    
    func makeMainViewModel()-> any MainViewModel
}

public protocol MainSceneFlowCoordinator: Coordinator {
    var dependencies: MainSceneFlowCoordinatorDependencies { get }
}
