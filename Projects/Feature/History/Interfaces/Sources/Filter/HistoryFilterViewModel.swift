//
//  HistoryFilterViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct HistoryFilterViewModelInput {
    
    public init() {  }
}

public struct HistoryFilterViewModelOutput {
    
    public init() {  }
}

public protocol HistoryFilterViewModel: ViewModel where Input == HistoryFilterViewModelInput, Output == HistoryFilterViewModelOutput {
    
}
