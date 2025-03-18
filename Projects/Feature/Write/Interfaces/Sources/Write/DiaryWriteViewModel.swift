//
//  DiaryWriteViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainWriteInterfaces
import RxSwift
import RxCocoa

public struct DiaryWriteViewModelAction {
    public let showSelectEmotion: ()-> Observable<Emotion?>
    public let showPhotoAlbum: ()-> Void
    public let showDeviceCamera: ()-> Void
    
    public init(
        showSelectEmotion: @escaping () -> Observable<Emotion?>,
        showPhotoAlbum: @escaping ()-> Void,
        showDeviceCamera: @escaping ()-> Void
    ) {
        self.showSelectEmotion = showSelectEmotion
        self.showPhotoAlbum = showPhotoAlbum
        self.showDeviceCamera = showDeviceCamera
    }
}

public struct DiaryWriteViewModelInput {
    public let emotionButtonTapped: Observable<Void>
    public let addPhotoButtonTapped: Observable<Void>
    public let captureCameraButtonTapped: Observable<Void>
    
    public init(
        emotionButtonTapped: Observable<Void>,
        addPhotoButtonTapped: Observable<Void>,
        captureCameraButtonTapped: Observable<Void>
    ) {
        self.emotionButtonTapped = emotionButtonTapped
        self.addPhotoButtonTapped = addPhotoButtonTapped
        self.captureCameraButtonTapped = captureCameraButtonTapped
    }
}

public struct DiaryWriteViewModelOutput {
    public let emotion: Driver<Emotion?>
    
    public init(
        emotion: Driver<Emotion?>
    ) {
        self.emotion = emotion
    }
}

public protocol DiaryWriteViewModel: ViewModel where Input == DiaryWriteViewModelInput, Output == DiaryWriteViewModelOutput {
    var emotion: Emotion? { get }
    var actions: DiaryWriteViewModelAction { get }
}
