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

public struct WriteSceneDIContainerDependencies {
    public let photoService: PhotoService
    public let photoSceneDIContainer: PhotoSceneDIContainer
    
    public init(
        photoService: PhotoService,
        photoSceneDIContainer: PhotoSceneDIContainer
    ) {
        self.photoService = photoService
        self.photoSceneDIContainer = photoSceneDIContainer
    }
}

public protocol WriteSceneDIContainer: WriteSceneFlowCoordinatorDependencies {
    var dependencies: WriteSceneDIContainerDependencies { get }
    
    func makeDiaryWriteSceneFlowCoordinator(navigationController: UINavigationController)-> WriteSceneFlowCoordinator
    func makeFetchPhotoAssetsUsecase()-> FetchPhotoAssetsUsecase
}
