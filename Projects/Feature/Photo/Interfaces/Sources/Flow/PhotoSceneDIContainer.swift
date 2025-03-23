//
//  PhotoSceneDIContainer.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import CorePhotoInterfaces
import DomainPhotoInterfaces
import Photos
import CoreStorageInterfaces

public struct PhotoSceneDIContainerDependencies {
    public let photoService: PhotoService
    public let imageStorage: FileStorage
    
    public init(
        photoService: PhotoService,
        imageStorage: FileStorage
    ) {
        self.photoService = photoService
        self.imageStorage = imageStorage
    }
}

public protocol PhotoSceneDIContainer: PhotoSceneFlowCoordinatorDependencies {
    var dependencies: PhotoSceneDIContainerDependencies { get }
    
    func makePhotoSceneFlowCoordinator(scene: PhotoScene, navController: UINavigationController, completion: @escaping ([FileInfo])-> Void)-> PhotoSceneFlowCoordinator
    func makeFetchPhotoAssetsUsecase() -> FetchPhotoAssetsUsecase
    func makeFetchAssetImageDataUsecase()-> FetchAssetImageDataUsecase
    func makeSavePhotoUsecase()-> SavePhotoUsecase
}
