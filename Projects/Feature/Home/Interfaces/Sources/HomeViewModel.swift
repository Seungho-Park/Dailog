//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces


public struct HomeViewModelInput {
    
    public init() {  }
}

public struct HomeViewModelOutput {
    
    public init() {  }
}

public protocol HomeViewModel: ViewModel where Input == HomeViewModelInput, Output == HomeViewModelOutput {
    
}
