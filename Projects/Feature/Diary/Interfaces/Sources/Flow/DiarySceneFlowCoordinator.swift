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
    func makeDiaryDetailViewModel(diary: Diary, actions: DiaryDetailViewModelAction)-> any DiaryDetailViewModel
    func makeEmotionViewModel(actions: EmotionViewModelActions)-> any EmotionViewModel
    func makeDatePickerViewModel(date: Date, actions: DatePickerAction)-> any DatePickerViewModel
}

public protocol DiarySceneFlowCoordinator: Coordinator {
    var diary: Diary? { get }
    var dependencies: DiarySceneFlowCoordinatorDependencies { get }
    
    func showSelectEmotionScene(completion: @escaping (Emotion?)-> Void)
    func showPhotoAlbumScene()-> Observable<[FileInfo]>
    func showDeviceCamera()-> Observable<[FileInfo]>
    func showDatePicker(date: Date)-> Observable<Date?>
}
