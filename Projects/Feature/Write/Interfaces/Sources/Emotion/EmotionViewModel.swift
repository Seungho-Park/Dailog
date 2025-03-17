//
//  EmotionViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct EmotionViewModelInput {
    
    public init() {  }
}

public struct EmotionViewModelOutput {
    
    public init() {  }
}

public protocol EmotionViewModel: ViewModel where Input == EmotionViewModelInput, Output == EmotionViewModelOutput {
    
}
