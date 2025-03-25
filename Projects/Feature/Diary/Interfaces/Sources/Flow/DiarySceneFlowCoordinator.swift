//
//  WriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainDiaryInterfaces
import FeaturePhotoInterfaces
import UIKit
import Photos
import RxSwift
import CoreStorageInterfaces

public protocol DiarySceneFlowCoordinatorDependencies {
    func makePhotoSceneFlowCoordinator(scene: PhotoScene, navigationController: UINavigationController, completion: @escaping ([FileInfo])-> Void)-> PhotoSceneFlowCoordinator
    
    func makeDiaryWriteViewModel(diary: Diary?, actions: DiaryWriteViewModelAction)-> any DiaryWriteViewModel
    func makeEmotionViewModel(actions: EmotionViewModelActions)-> any EmotionViewModel
}

public protocol DiarySceneFlowCoordinator: Coordinator {
    var dependencies: DiarySceneFlowCoordinatorDependencies { get }
    
    func showSelectEmotionScene(completion: @escaping (Emotion?)-> Void)
    func showPhotoAlbumScene()-> Observable<[FileInfo]>
    func showDeviceCamera()-> Observable<[FileInfo]>
}
