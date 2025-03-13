//
//  ReminderViewModel.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct ReminderViewModelInput {
    public init() {
        
    }
}

public struct ReminderViewModelOutput {
    public init() {
        
    }
}

public protocol ReminderViewModel: ViewModel where Input == ReminderViewModelInput, Output == ReminderViewModelOutput {
    
}
