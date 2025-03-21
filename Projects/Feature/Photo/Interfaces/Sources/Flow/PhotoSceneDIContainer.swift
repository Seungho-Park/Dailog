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

public struct PhotoSceneDIContainerDependencies {
    public let photoService: PhotoService
    
    public init(photoService: PhotoService) {
        self.photoService = photoService
    }
}

public protocol PhotoSceneDIContainer: PhotoSceneFlowCoordinatorDependencies {
    var dependencies: PhotoSceneDIContainerDependencies { get }
    
    func makePhotoSceneFlowCoordinator(scene: PhotoScene, navController: UINavigationController, completion: @escaping ([PHAsset])-> Void)-> PhotoSceneFlowCoordinator
    func makeFetchPhotoAssetsUsecase() -> FetchPhotoAssetsUsecase
    func makeFetchAssetImageDataUsecase()-> FetchAssetImageDataUsecase
}
