//
//  DefaultHistorySceneDIContainer.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureHistoryInterfaces
import DomainDiary
import DomainDiaryInterfaces
import DomainPhotoInterfaces
import DomainPhoto
import FeatureDiaryInterfaces

public final class DefaultHistorySceneDIContainer: HistorySceneDIContainer {
    public let dependencies: HistorySceneDIContainerDependencies
    
    public init(dependencies: HistorySceneDIContainerDependencies) {
        self.dependencies = dependencies
    }
    
    public func makeHistorySceneFlowCoordinator(navigationController: UINavigationController) -> HistorySceneFlowCoordinator {
        return DefaultHistorySceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DefaultHistorySceneDIContainer {
    public func makeWriteSceneFlowCoordinator(diary: Diary?, navigationController: UINavigationController) -> any DiarySceneFlowCoordinator {
        let diContainer = dependencies.diarySceneDIContainer
        return diContainer.makeDiaryWriteSceneFlowCoordinator(diary: diary, navigationController: navigationController)
    }
    
    public func makeHistoryViewModel(actions: HistoryViewModelAction) -> any HistoryViewModel {
        return DefaultHistoryViewModel(
            fetchDiariesUsecase: makeFetchDiariesUsecase(),
            fetchPhotoDataUsecase: makeFetchPhotoDataUsecase(),
            actions: actions
        )
    }
    
    public func makeHistoryFilterViewModel(filter: HistoryFilterType, actions: HistoryFilterViewModelAction) -> any HistoryFilterViewModel {
        return DefaultHistoryFilterViewModel(filter: filter, actions: actions)
    }
    
    public func makeFetchDiariesUsecase() -> FetchDiariesUsecase {
        return FetchDiariesUsecaseImpl(repository: makeDiaryRepository())
    }
    
    public func makeFetchPhotoDataUsecase() -> any FetchPhotoDataUsecase {
        return FetchPhotoDataUsecaseImpl(repository: makePhotoStorageRepository())
    }
    
    private func makeDiaryRepository()-> DiaryRepository {
        return DiaryRepositoryImpl(storage: dependencies.diaryStorage)
    }
    
    private func makePhotoStorageRepository()-> PhotoStorageRepository {
        return PhotoStorageRepositoryImpl(fileStorage: dependencies.imageFileStorage, photoService: dependencies.photoService)
    }
}
