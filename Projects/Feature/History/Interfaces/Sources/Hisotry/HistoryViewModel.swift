//
//  HistoryViewModel.swift
//  FeatureCalendar
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct HistoryViewModelInput {
    
    public init() {
        
    }
}

public struct HistoryViewModelOutput {
    
    public init() {
        
    }
}

public protocol HistoryViewModel: ViewModel where Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    
}
