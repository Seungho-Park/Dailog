//
//  DefaultEmotionViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import SharedUI
import FeatureWriteInterfaces
import RxSwift
import RxCocoa

public final class DefaultEmotionViewModel: EmotionViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public let actions: EmotionViewModelActions
    
    public init(actions: EmotionViewModelActions) {
        self.actions = actions
    }
    
    public func transform(input: EmotionViewModelInput) -> EmotionViewModelOutput {
        input.select
            .debug()
            .bind(onNext: actions.selectEmotion)
            .disposed(by: disposeBag)
        
        return .init()
    }
}
