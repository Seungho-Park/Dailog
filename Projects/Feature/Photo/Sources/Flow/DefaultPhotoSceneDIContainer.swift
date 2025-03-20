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

public final class DefaultPhotoSceneDIContainer: PhotoSceneDIContainer {
    public let dependencies: PhotoSceneDIContainerDependencies
    public init(
        dependencies: PhotoSceneDIContainerDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultPhotoSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
    
    public func makeGalleryViewModel() -> any GalleryViewModel {
        return DefaultGalleryViewModel(
            fetchPhotoAssetsUsecase: makeFetchPhotoAssetsUsecase(),
            fetchAssetImageDataUsecase: makeFetchAssetImageDataUsecase()
        )
    }
    
    public func makeFetchPhotoAssetsUsecase() -> FetchPhotoAssetsUsecase {
        return FetchPhotoAssetsUsecaseImpl(repository: makePhotoRepository())
    }
    
    public func makeFetchAssetImageDataUsecase() -> any FetchAssetImageDataUsecase {
        return FetchAssetImageDataUsecaseImpl(repository: makePhotoRepository())
    }
    
    private func makePhotoRepository()-> PhotoRepository {
        return PhotoRepositoryImpl(photoService: dependencies.photoService)
    }
}
