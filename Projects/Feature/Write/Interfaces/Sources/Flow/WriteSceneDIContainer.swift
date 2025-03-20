//
//  WriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import CorePhotoInterfaces
import DomainPhotoInterfaces

public struct WriteSceneDIContainerDependencies {
    public let photoService: PhotoService
    public let photoSceneDIContainer: ()-> any DIContainer
    
    public init(
        photoService: PhotoService,
        photoSceneDIContainer: @escaping () -> any DIContainer
    ) {
        self.photoService = photoService
        self.photoSceneDIContainer = photoSceneDIContainer
    }
}

public protocol WriteSceneDIContainer: DIContainer, WriteSceneFlowCoordinatorDependencies {
    var dependencies: WriteSceneDIContainerDependencies { get }
    
    func makeFetchPhotoAssetsUsecase()-> FetchPhotoAssetsUsecase
}
