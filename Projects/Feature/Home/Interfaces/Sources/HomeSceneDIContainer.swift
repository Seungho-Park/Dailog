//
//  HomeSceneDIContainer.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import DomainHomeInterfaces
import FeatureWriteInterfaces

public struct HomeSceneDIContainerDependencies {
    public let diaryWriteDIContainer: WriteSceneDIContainer
    
    public init(diaryWriteDIContainer: WriteSceneDIContainer) {
        self.diaryWriteDIContainer = diaryWriteDIContainer
    }
}

public protocol HomeSceneDIContainer: HomeSceneFlowCoordinatorDependencies {
    var dependencies: HomeSceneDIContainerDependencies { get }
    
    func makeHomeSceneFlowCoordinator(navigationController: UINavigationController) -> HomeSceneFlowCoordinator
    func makeFetchRandomPromptUsecase() -> FetchRandomPromptUsecase
    func makeFetchRandomAdviceUsecase() -> FetchRandomAdviceUsecase
}
