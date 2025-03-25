//
//  DefaultWriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureDiaryInterfaces
import SharedUIInterfaces
import FeaturePhotoInterfaces
import DomainDiaryInterfaces
import DomainPhotoInterfaces
import DomainPhoto
import Photos
import CoreStorageInterfaces
import DomainDiary

public final class DefaultDiarySceneDIContainer: DiarySceneDIContainer {
    public let dependencies: DiarySceneDIContainerDependencies
    
    public init(
        dependencies: DiarySceneDIContainerDependencies
    ) {
        self.dependencies = dependencies
    }
    
    public func makePhotoSceneFlowCoordinator(scene: PhotoScene, navigationController: UINavigationController, completion: @escaping ([FileInfo]) -> Void) -> any PhotoSceneFlowCoordinator {
        return dependencies.photoSceneDIContainer.makePhotoSceneFlowCoordinator(scene: scene, navController: navigationController, completion: completion)
    }
    
    public func makeDiaryWriteSceneFlowCoordinator(navigationController: UINavigationController)-> DiarySceneFlowCoordinator {
        return DefaultDiarySceneFlowCoordinator(navigationController: navigationController, dependencies: self)
    }
    
    public func makeDiaryWriteViewModel(diary: Diary?, actions: DiaryWriteViewModelAction) -> any DiaryWriteViewModel {
        return DefaultDiaryWriteViewModel(
            diary: diary,
            fetchPhotoAssetsUsecase: makeFetchPhotoAssetsUsecase(),
            fetchPhotoDataUsecase: makeFetchPhotoDataUsecase(),
            deletePhotoFileUsecase: makeDeletePhotoFileUsecase(),
            saveDiaryUsecase: makeSaveDiaryUsecase(),
            actions: actions
        )
    }
    
    public func makeDeletePhotoFileUsecase() -> any DeletePhotoFileUsecase {
        return DeletePhotoFileUsecaseImpl(repository: makePhotoStorageRepository())
    }
    
    public func makeEmotionViewModel(actions: EmotionViewModelActions) -> any EmotionViewModel {
        return DefaultEmotionViewModel(actions: actions)
    }
    
    public func makeFetchPhotoDataUsecase() -> any FetchPhotoDataUsecase {
        return FetchPhotoDataUsecaseImpl(repository: makePhotoStorageRepository())
    }
    
    public func makeFetchPhotoAssetsUsecase() -> any FetchPhotoAssetsUsecase {
        return FetchPhotoAssetsUsecaseImpl(repository: GalleryRepositoryImpl(photoService: dependencies.photoService))
    }
    
    public func makeSaveDiaryUsecase() -> any SaveDiaryUsecase {
        return SaveDiaryUsecaseImpl(repository: makeDiaryRepository())
    }
    
    private func makePhotoStorageRepository()-> PhotoStorageRepository {
        return PhotoStorageRepositoryImpl(fileStorage: dependencies.imageStorage, photoService: dependencies.photoService)
    }
    
    private func makeDiaryRepository()-> DiaryRepository {
        return DiaryRepositoryImpl(storage: dependencies.diaryStorage)
    }
}
