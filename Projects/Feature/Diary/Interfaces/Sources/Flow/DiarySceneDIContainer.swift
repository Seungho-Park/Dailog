//
//  WriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import CorePhotoInterfaces
import DomainPhotoInterfaces
import FeaturePhotoInterfaces
import CoreStorageInterfaces
import DomainDiaryInterfaces

public struct DiarySceneDIContainerDependencies {
    public let photoService: PhotoService
    public let photoSceneDIContainer: PhotoSceneDIContainer
    public let imageStorage: FileStorage
    public let diaryStorage: DiaryStorage
    
    public init(
        photoService: PhotoService,
        photoSceneDIContainer: PhotoSceneDIContainer,
        imageStorage: FileStorage,
        diaryStorage: DiaryStorage
    ) {
        self.photoService = photoService
        self.photoSceneDIContainer = photoSceneDIContainer
        self.imageStorage = imageStorage
        self.diaryStorage = diaryStorage
    }
}

public protocol DiarySceneDIContainer: DiarySceneFlowCoordinatorDependencies {
    var dependencies: DiarySceneDIContainerDependencies { get }
    
    func makeDiaryWriteSceneFlowCoordinator(navigationController: UINavigationController)-> DiarySceneFlowCoordinator
    func makeFetchPhotoAssetsUsecase()-> FetchPhotoAssetsUsecase
    func makeFetchPhotoDataUsecase()-> FetchPhotoDataUsecase
    func makeDeletePhotoFileUsecase()-> DeletePhotoFileUsecase
    func makeSaveDiaryUsecase()-> SaveDiaryUsecase
}
