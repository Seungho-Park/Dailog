//
//  WriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainWriteInterfaces
import FeaturePhotoInterfaces
import UIKit
import Photos

public protocol WriteSceneFlowCoordinatorDependencies {
    func makePhotoSceneFlowCoordinator(scene: PhotoScene, navigationController: UINavigationController, completion: @escaping ([PHAsset])-> Void)-> PhotoSceneFlowCoordinator
    
    func makeDiaryWriteViewModel(emotion: Emotion?, actions: DiaryWriteViewModelAction)-> any DiaryWriteViewModel
    func makeEmotionViewModel(actions: EmotionViewModelActions)-> any EmotionViewModel
}

public protocol WriteSceneFlowCoordinator: Coordinator {
    var dependencies: WriteSceneFlowCoordinatorDependencies { get }
    
    func showSelectEmotionScene(completion: @escaping (Emotion?)-> Void)
    func showPhotoAlbumScene()
    func showDeviceCamera()
}
