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

public struct HistorySceneDIContainerDependencies {
    public let diaryStorage: DiaryCoreDataStorage
    public let imageFileStorage: FileStorage
    public let photoService: PhotoService
    
    public init(
        diaryStorage: DiaryCoreDataStorage,
        imageFileStorage: FileStorage,
        photoService: PhotoService
    ) {
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
