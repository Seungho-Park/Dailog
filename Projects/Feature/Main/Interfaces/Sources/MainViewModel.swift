//
//  MainViewModel.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct MainViewModelInput {
    
    public init() {  }
}

public struct MainViewModelOutput {
    
    public init() {  }
}

public protocol MainViewModel: ViewModel where Input == MainViewModelInput, Output == MainViewModelOutput {
    
}
