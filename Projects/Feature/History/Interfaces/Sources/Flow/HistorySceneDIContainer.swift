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
import CoreStorageInterfaces
import CorePhotoInterfaces
import DomainPhotoInterfaces
import FeatureDiaryInterfaces

public struct HistorySceneDIContainerDependencies {
    public let diarySceneDIContainer: DiarySceneDIContainer
    public let diaryStorage: DiaryStorage
    public let imageFileStorage: FileStorage
    public let photoService: PhotoService
    
    public init(
        diarySceneDIContainer: DiarySceneDIContainer,
        diaryStorage: DiaryStorage,
        imageFileStorage: FileStorage,
        photoService: PhotoService
    ) {
        self.diarySceneDIContainer = diarySceneDIContainer
        self.diaryStorage = diaryStorage
        self.imageFileStorage = imageFileStorage
        self.photoService = photoService
    }
}

public protocol HistorySceneDIContainer: HistorySceneFlowCoordinatorDependencies {
    var dependencies: HistorySceneDIContainerDependencies { get }
    
    func makeHistorySceneFlowCoordinator(navigationController: UINavigationController) -> HistorySceneFlowCoordinator
    func makeFetchDiariesUsecase()-> FetchDiariesUsecase
    func makeFetchPhotoDataUsecase()-> FetchPhotoDataUsecase
}
