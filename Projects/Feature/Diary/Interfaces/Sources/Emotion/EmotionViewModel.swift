//
//  EmotionViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainDiaryInterfaces
import RxSwift
import RxCocoa

public struct EmotionViewModelActions {
    public let selectEmotion: (Emotion?) -> Void

    public init(selectEmotion: @escaping (Emotion?) -> Void) {
        self.selectEmotion = selectEmotion
    }
}

public struct EmotionViewModelInput {
    
    public let select: Observable<Emotion?>
    
    public init(select: Observable<Emotion?>) {
        self.select = select
    }
}

public struct EmotionViewModelOutput {
    
    public init() {  }
}

public protocol EmotionViewModel: ViewModel where Input == EmotionViewModelInput, Output == EmotionViewModelOutput {
    var actions: EmotionViewModelActions { get }
}
