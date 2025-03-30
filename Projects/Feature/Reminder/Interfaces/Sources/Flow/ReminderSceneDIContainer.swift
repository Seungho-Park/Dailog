//
//  ReminderSceneDIContainer.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import DomainDiaryInterfaces
import CoreStorageInterfaces

public struct ReminderSceneDependencies {
    public let diaryStorage: DiaryStorage
    
    public init(
        diaryStorage: DiaryStorage
    ) {
        self.diaryStorage = diaryStorage
    }
}

public protocol ReminderSceneDIContainer: ReminderSceneFlowCoordinatorDependencies {
    var dependencies: ReminderSceneDependencies { get }
    
    func makeReminderSceneFlowCoordinator(navigationController: UINavigationController)-> ReminderSceneFlowCoordinator
    
    func makeFetchDiariesUsecase()-> FetchDiariesUsecase
}
