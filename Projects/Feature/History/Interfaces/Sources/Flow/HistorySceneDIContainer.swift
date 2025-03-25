//
//  HistorySceneDIContainer.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import DomainDiaryInterfaces
import CoreStorage

public struct HistorySceneDIContainerDependencies {
    public let diaryStorage: DiaryCoreDataStorage
    
    public init(diaryStorage: DiaryCoreDataStorage) {
        self.diaryStorage = diaryStorage
    }
}

public protocol HistorySceneDIContainer: HistorySceneFlowCoordinatorDependencies {
    var dependencies: HistorySceneDIContainerDependencies { get }
    
    func makeHistorySceneFlowCoordinator(navigationController: UINavigationController) -> HistorySceneFlowCoordinator
    func makeFetchDiariesUsecase()-> FetchDiariesUsecase
}
