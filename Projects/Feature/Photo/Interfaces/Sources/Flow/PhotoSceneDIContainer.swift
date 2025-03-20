//
//  PhotoSceneDIContainer.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import CorePhotoInterfaces
import DomainPhotoInterfaces

public struct PhotoSceneDIContainerDependencies {
    public let photoService: PhotoService
    
    public init(photoService: PhotoService) {
        self.photoService = photoService
    }
}

public protocol PhotoSceneDIContainer: DIContainer, PhotoSceneFlowCoordinatorDependencies {
    var dependencies: PhotoSceneDIContainerDependencies { get }
    
    func makeFetchPhotoAssetsUsecase() -> FetchPhotoAssetsUsecase
    func makeFetchAssetImageDataUsecase()-> FetchAssetImageDataUsecase
}
