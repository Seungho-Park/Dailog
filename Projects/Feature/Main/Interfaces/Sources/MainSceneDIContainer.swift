//
//  MainSceneDIContainer.swift
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

public struct MainSceneDIContainerDependencies {
    public let homeSceneDIContainer: HomeSceneDIContainer
    public let historySceneDIContainer: HistorySceneDIContainer
    public let reminderSceneDIContainer: ReminderSceneDIContainer
    public let settingsSceneDIContainer: SettingsSceneDIContainer
    
    public init(
        homeSceneDIContainer: HomeSceneDIContainer,
        historySceneDIContainer: HistorySceneDIContainer,
        reminderSceneDIContainer: ReminderSceneDIContainer,
        settingsSceneDIContainer: SettingsSceneDIContainer
    ) {
        self.homeSceneDIContainer = homeSceneDIContainer
        self.historySceneDIContainer = historySceneDIContainer
        self.reminderSceneDIContainer = reminderSceneDIContainer
        self.settingsSceneDIContainer = settingsSceneDIContainer
    }
}

public protocol MainSceneDIContainer {
    var dependencies: MainSceneDIContainerDependencies { get }
    
    func makeMainSceneFlowCoordinator(navigationController: UINavigationController)-> MainSceneFlowCoordinator
}
