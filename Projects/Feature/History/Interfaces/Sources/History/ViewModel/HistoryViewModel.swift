//
//  HistoryViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 7/3/25.
//

import SharedUI

public struct HistoryViewModelAction {
    
    public init() {
        
    }
}

public struct HistoryViewModelInput {
    
    public init() {
        
    }
}

public struct HistoryViewModelOutput {
    
    public init() {
        
    }
}

public protocol HistoryViewModel: ViewModel where Action == HistoryViewModelAction, Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    
}
