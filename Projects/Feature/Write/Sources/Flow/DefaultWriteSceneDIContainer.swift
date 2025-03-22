//
//  DefaultWriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureWriteInterfaces
import SharedUIInterfaces
import FeaturePhotoInterfaces
import DomainWriteInterfaces
import DomainPhotoInterfaces
import DomainPhoto
import Photos

public final class DefaultWriteSceneDIContainer: WriteSceneDIContainer {
    public let dependencies: WriteSceneDIContainerDependencies
    
    public init(
        dependencies: WriteSceneDIContainerDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makePhotoSceneFlowCoordinator(scene: PhotoScene, navigationController: UINavigationController, completion: @escaping ([String]) -> Void) -> any PhotoSceneFlowCoordinator {
        return dependencies.photoSceneDIContainer.makePhotoSceneFlowCoordinator(scene: scene, navController: navigationController, completion: completion)
    }
    
    public func makeDiaryWriteSceneFlowCoordinator(navigationController: UINavigationController)-> WriteSceneFlowCoordinator {
        return DefaultWriteSceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    public func makeDiaryWriteViewModel(emotion: Emotion?, actions: DiaryWriteViewModelAction) -> any DiaryWriteViewModel {
        return DefaultDiaryWriteViewModel(
            emotion: emotion,
            fetchPhotoAssetsUsecase: makeFetchPhotoAssetsUsecase(),
            actions: actions
        )
    }
    
    public func makeEmotionViewModel(actions: EmotionViewModelActions) -> any EmotionViewModel {
        return DefaultEmotionViewModel(actions: actions)
    }
    
    public func makeFetchPhotoAssetsUsecase() -> any FetchPhotoAssetsUsecase {
        return FetchPhotoAssetsUsecaseImpl(repository: GalleryRepositoryImpl(photoService: dependencies.photoService))
    }
}
