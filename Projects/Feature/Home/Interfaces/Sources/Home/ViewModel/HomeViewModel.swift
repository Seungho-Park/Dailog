//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 7/3/25.
//

import SharedUI

public struct HomeViewModelAction {
    
    public init() {
        
    }
}

public struct HomeViewModelInput {
    
    public init() {
        
    }
}

public struct HomeViewModelOutput {
    
    public init() {
        
    }
}

public protocol HomeViewModel: ViewModel where Action == HomeViewModelAction, Input == HomeViewModelInput, Output == HomeViewModelOutput {
    
}
