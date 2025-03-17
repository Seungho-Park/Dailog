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
    public let showSelectEmotion: ()-> Void
    
    public init(showSelectEmotion: @escaping () -> Void) {
        self.showSelectEmotion = showSelectEmotion
    }
}

public struct DiaryWriteViewModelInput {
    
    public init() {  }
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
