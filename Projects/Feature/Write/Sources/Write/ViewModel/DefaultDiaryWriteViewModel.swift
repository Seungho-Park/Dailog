//
//  DefaultDiaryWriteViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUI
import FeatureWriteInterfaces
import SharedUIInterfaces
import RxSwift
import RxCocoa
import DomainWriteInterfaces
import DomainPhotoInterfaces
import Photos

public final class DefaultDiaryWriteViewModel: DiaryWriteViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public let emotion: Emotion?
    public let fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase
    public let actions: DiaryWriteViewModelAction
    
    public init(
        emotion: Emotion?,
        fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase,
        actions: DiaryWriteViewModelAction
    ) {
        self.emotion = emotion
        self.fetchPhotoAssetsUsecase = fetchPhotoAssetsUsecase
        self.actions = actions
    }
    
    public func transform(input: DiaryWriteViewModelInput) -> DiaryWriteViewModelOutput {
        let photoAssets: BehaviorRelay<[PHAsset]> = .init(value: [])
        let emotion: BehaviorRelay<Emotion?> = .init(value: emotion)
        
        Observable.merge(
            input.emotionButtonTapped,
            emotion.take(1).filter { $0 == nil }.map { _ in }
        )
        .withUnretained(self)
        .flatMap { owner, _ in
            return owner.actions.showSelectEmotion()
        }
        .bind(to: emotion)
        .disposed(by: disposeBag)
        
        Observable<Bool>.create { observer in
            observer.onNext(PHPhotoLibrary.authorizationStatus() == .authorized)
            observer.onCompleted()
            return Disposables.create()
        }
        .filter { $0 }
        .withUnretained(self)
        .flatMap { owner, _ in
            owner.fetchPhotoAssetsUsecase.execute(size: .init(width: 150, height: 150))
        }
        .catchAndReturn([])
        .bind(to: photoAssets)
        .disposed(by: disposeBag)
        
        input.backButtonTapped?
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        input.addPhotoButtonTapped
            .bind(onNext: actions.showPhotoAlbum)
            .disposed(by: disposeBag)
        
        input.captureCameraButtonTapped
            .bind(onNext: actions.showDeviceCamera)
            .disposed(by: disposeBag)
        
        return .init(
            emotion: emotion.asDriver()
        )
    }
}
