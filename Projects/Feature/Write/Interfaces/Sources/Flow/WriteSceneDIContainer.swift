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

public struct WriteSceneDIContainerDependencies {
    public let photoService: PhotoService
    public let photoSceneDIContainer: PhotoSceneDIContainer
    public let imageStorage: FileStorage
    
    public init(
        photoService: PhotoService,
        photoSceneDIContainer: PhotoSceneDIContainer,
        imageStorage: FileStorage
    ) {
        self.photoService = photoService
        self.photoSceneDIContainer = photoSceneDIContainer
        self.imageStorage = imageStorage
    }
}

public protocol WriteSceneDIContainer: WriteSceneFlowCoordinatorDependencies {
    var dependencies: WriteSceneDIContainerDependencies { get }
    
    func makeDiaryWriteSceneFlowCoordinator(navigationController: UINavigationController)-> WriteSceneFlowCoordinator
    func makeFetchPhotoAssetsUsecase()-> FetchPhotoAssetsUsecase
    func makeFetchPhotoDataUsecase()-> FetchPhotoDataUsecase
    func makeDeletePhotoFileUsecase()-> DeletePhotoFileUsecase
}
