//
//  SplashViewModel.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces

public struct SplashViewModelInput {
    
    public init() {  }
}

public struct SplashViewModelOutput {
    
    public init() {  }
}

public protocol SplashViewModel: ViewModel where Input == SplashViewModelInput, Output == SplashViewModelOutput {
    
}
