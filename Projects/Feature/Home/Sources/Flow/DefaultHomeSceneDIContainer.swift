//
//  DefaultHomeSceneDIContainer.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureWriteInterfaces
import FeatureHomeInterfaces
import DomainHomeInterfaces
import DomainHome
import SharedUIInterfaces

public final class DefaultHomeSceneDIContainer: HomeSceneDIContainer {    
    public let dependencies: HomeSceneDIContainerDependencies
    
    public init(dependencies: HomeSceneDIContainerDependencies) {
        self.dependencies = dependencies
    }
    
    public func makeHomeSceneFlowCoordinator(navigationController: UINavigationController) -> HomeSceneFlowCoordinator {
        return DefaultHomeSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    public func makeFetchRandomPromptUsecase() -> FetchRandomPromptUsecase {
        return FetchRandomPromptUsecaseImpl(repository: makeHomeRepository())
    }
    
    public func makeFetchRandomAdviceUsecase() -> any FetchRandomAdviceUsecase {
        return FetchRandomAdviceUsecaseImpl(repository: makeHomeRepository())
    }
}

extension DefaultHomeSceneDIContainer {
    public func makeWriteSceneFlowCoordinator(navigationController: UINavigationController) -> any WriteSceneFlowCoordinator {
        return dependencies.diaryWriteDIContainer.makeDiaryWriteSceneFlowCoordinator(navigationController: navigationController)
    }
    
    public func makeHomeViewModel(actions: HomeViewModelAction) -> any HomeViewModel {
        return DefaultHomeViewModel(
            fetchRandomPromptUsecase: makeFetchRandomPromptUsecase(),
            fetchRandomAdviceUsecase: makeFetchRandomAdviceUsecase(),
            actions: actions
        )
    }
}

extension DefaultHomeSceneDIContainer {
    private func makeHomeRepository()-> HomeRepository {
        return HomeRepositoryImpl()
    }
}
