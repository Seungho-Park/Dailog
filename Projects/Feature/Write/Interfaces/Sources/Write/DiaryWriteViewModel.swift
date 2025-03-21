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
import DomainPhotoInterfaces

public struct DiaryWriteViewModelAction {
    public let close: ()-> Void
    public let showSelectEmotion: ()-> Observable<Emotion?>
    public let showPhotoAlbum: ()-> Void
    public let showDeviceCamera: ()-> Void
    
    public init(
        close: @escaping ()-> Void,
        showSelectEmotion: @escaping () -> Observable<Emotion?>,
        showPhotoAlbum: @escaping ()-> Void,
        showDeviceCamera: @escaping ()-> Void
    ) {
        self.close = close
        self.showSelectEmotion = showSelectEmotion
        self.showPhotoAlbum = showPhotoAlbum
        self.showDeviceCamera = showDeviceCamera
    }
}

public struct DiaryWriteViewModelInput {
    public let backButtonTapped: Observable<Void>?
    public let emotionButtonTapped: Observable<Void>
    public let addPhotoButtonTapped: Observable<Void>
    public let captureCameraButtonTapped: Observable<Void>
    
    public init(
        backButtonTapped: Observable<Void>?,
        emotionButtonTapped: Observable<Void>,
        addPhotoButtonTapped: Observable<Void>,
        captureCameraButtonTapped: Observable<Void>
    ) {
        self.backButtonTapped = backButtonTapped
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
    var fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase { get }
    var actions: DiaryWriteViewModelAction { get }
}
