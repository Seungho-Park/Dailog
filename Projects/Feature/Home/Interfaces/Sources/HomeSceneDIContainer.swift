//
//  HomeSceneDIContainer.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainHomeInterfaces

public struct HomeSceneDIContainerDependencies {
    
    public init() {
    }
}

public protocol HomeSceneDIContainer: DIContainer, HomeSceneFlowCoordinatorDependencies {
    var dependencies: HomeSceneDIContainerDependencies { get }
    
    func makeFetchRandomPromptUsecase() -> FetchRandomPromptUsecase
}
