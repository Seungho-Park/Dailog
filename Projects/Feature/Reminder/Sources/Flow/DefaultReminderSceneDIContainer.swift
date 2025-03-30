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
import DomainDiaryInterfaces
import DomainDiary

public final class DefaultReminderSceneDIContainer: ReminderSceneDIContainer {
    public let dependencies: ReminderSceneDependencies
    
    public init(
        dependencies: ReminderSceneDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makeReminderSceneFlowCoordinator(navigationController: UINavigationController)-> ReminderSceneFlowCoordinator {
        return DefaultReminderSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    public func makeReminderViewModel() -> any ReminderViewModel {
        return DefaultReminderViewModel(
            fetchDiariesUsecase: makeFetchDiariesUsecase()
        )
    }
    
    public func makeFetchDiariesUsecase() -> FetchDiariesUsecase {
        return FetchDiariesUsecaseImpl(repository: makeDiaryRepository())
    }
    
    private func makeDiaryRepository()-> DiaryRepository {
        return DiaryRepositoryImpl(storage: dependencies.diaryStorage)
    }
}
