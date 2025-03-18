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

public final class DefaultDiaryWriteViewModel: DiaryWriteViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    public let navigationBarStyle: NavigationBarStyle = .default(title: "")
    
    public let emotion: Emotion?
    public let actions: DiaryWriteViewModelAction
    
    public init(
        emotion: Emotion?,
        actions: DiaryWriteViewModelAction
    ) {
        self.emotion = emotion
        self.actions = actions
    }
    
    public func transform(input: DiaryWriteViewModelInput) -> DiaryWriteViewModelOutput {
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
