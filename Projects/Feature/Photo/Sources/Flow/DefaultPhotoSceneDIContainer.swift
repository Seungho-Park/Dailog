//
//  DefaultPhotoSceneDIContainer.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeaturePhotoInterfaces
import DomainPhotoInterfaces
import DomainPhoto
import Photos

public final class DefaultPhotoSceneDIContainer: PhotoSceneDIContainer {
    public let dependencies: PhotoSceneDIContainerDependencies
    public init(
        dependencies: PhotoSceneDIContainerDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makePhotoSceneFlowCoordinator(scene: PhotoScene, navController: UINavigationController, completion: @escaping ([String]) -> Void) -> PhotoSceneFlowCoordinator  {
        return DefaultPhotoSceneFlowCoordinator(
            scene: scene,
            navigationController: navController,
            dependencies: self,
            completion: completion
        )
    }
    
    public func makeGalleryViewModel(actions: GalleryViewModelAction) -> any GalleryViewModel {
        return DefaultGalleryViewModel(
            fetchPhotoAssetsUsecase: makeFetchPhotoAssetsUsecase(),
            fetchAssetImageDataUsecase: makeFetchAssetImageDataUsecase(),
            savePhotoUsecaes: makeSavePhotoUsecase(),
            actions: actions
        )
    }
    
    public func makeCameraViewModel(actions: CameraViewModelAction) -> any CameraViewModel {
        return DefaultCameraViewModel(savePhotoUsecaes: makeSavePhotoUsecase(), actions: actions)
    }
    
    public func makeSavePhotoUsecase() -> any SavePhotoUsecase {
        return SavePhotoUsecaseImpl(repoisitory: makePhotoStorageRepository())
    }
    
    public func makeFetchPhotoAssetsUsecase() -> FetchPhotoAssetsUsecase {
        return FetchPhotoAssetsUsecaseImpl(repository: makeGalleryRepository())
    }
    
    public func makeFetchAssetImageDataUsecase() -> any FetchAssetImageDataUsecase {
        return FetchAssetImageDataUsecaseImpl(repository: makeGalleryRepository())
    }
    
    private func makeGalleryRepository()-> GalleryRepository {
        return GalleryRepositoryImpl(photoService: dependencies.photoService)
    }
    
    private func makePhotoStorageRepository()-> PhotoStorageRepository {
        return PhotoStorageRepositoryImpl(fileStorage: dependencies.imageStorage, photoService: dependencies.photoService)
    }
}
