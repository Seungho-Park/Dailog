//
//  DiaryWriteViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces
import DomainDiaryInterfaces
import RxSwift
import RxCocoa
import DomainPhotoInterfaces
import CoreStorageInterfaces

public struct DiaryWriteViewModelAction {
    public let close: ()-> Void
    public let showSelectEmotion: ()-> Observable<Emotion?>
    public let showPhotoAlbum: ()-> Observable<[FileInfo]>
    public let showDeviceCamera: ()-> Observable<[FileInfo]>
    public let showDatePicker: ()-> Observable<Date?>
    
    public init(
        close: @escaping ()-> Void,
        showSelectEmotion: @escaping () -> Observable<Emotion?>,
        showPhotoAlbum: @escaping ()-> Observable<[FileInfo]>,
        showDeviceCamera: @escaping ()-> Observable<[FileInfo]>,
        showDatePicker: @escaping ()-> Observable<Date?>
    ) {
        self.close = close
        self.showSelectEmotion = showSelectEmotion
        self.showPhotoAlbum = showPhotoAlbum
        self.showDeviceCamera = showDeviceCamera
        self.showDatePicker = showDatePicker
    }
}

public struct DiaryWriteViewModelInput {
    public let backButtonTapped: Observable<Void>?
    public let emotionButtonTapped: Observable<Void>
    public let addPhotoButtonTapped: Observable<Void>
    public let captureCameraButtonTapped: Observable<Void>
    public let photoDeleteButtonTapped: Observable<String>
    public let saveButtonTapped: Observable<Void>?
    public let textChanged: Observable<String>
    public let dateChangeButtonTapped: Observable<Void>?
    
    public init(
        backButtonTapped: Observable<Void>?,
        emotionButtonTapped: Observable<Void>,
        addPhotoButtonTapped: Observable<Void>,
        captureCameraButtonTapped: Observable<Void>,
        photoDeleteButtonTapped: Observable<String>,
        saveButtonTapped: Observable<Void>?,
        textChanged: Observable<String>,
        dateChangeButtonTapped: Observable<Void>?
    ) {
        self.backButtonTapped = backButtonTapped
        self.emotionButtonTapped = emotionButtonTapped
        self.addPhotoButtonTapped = addPhotoButtonTapped
        self.captureCameraButtonTapped = captureCameraButtonTapped
        self.photoDeleteButtonTapped = photoDeleteButtonTapped
        self.saveButtonTapped = saveButtonTapped
        self.textChanged = textChanged
        self.dateChangeButtonTapped = dateChangeButtonTapped
    }
}

public struct DiaryWriteViewModelOutput {
    public let emotion: Driver<Emotion?>
    public let contents: Driver<String>
    public let date: Driver<Date>
    public let photos: Driver<[FileInfo]>
    
    public init(
        emotion: Driver<Emotion?>,
        contents: Driver<String>,
        date: Driver<Date>,
        photos: Driver<[FileInfo]>
    ) {
        self.emotion = emotion
        self.contents = contents
        self.date = date
        self.photos = photos
    }
}

public protocol DiaryWriteViewModel: ViewModel where Input == DiaryWriteViewModelInput, Output == DiaryWriteViewModelOutput {
    var diary: Diary? { get }
    var fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase { get }
    var fetchPhotoDataUsecase: FetchPhotoDataUsecase { get }
    var deletePhotoFileUsecase: DeletePhotoFileUsecase { get }
    var saveDiaryUsecase: SaveDiaryUsecase { get }
    var actions: DiaryWriteViewModelAction { get }
}
