//
//  MainStore.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import ComposableArchitecture
import SharedUIInterfaces

public enum MainState: Equatable {
    case initialize
    
    public init() {
        self = .initialize
    }
}

public enum MainAction: Equatable {
    
}

public protocol MainStore: DailogStore where State == MainState, Action == MainAction {
    
}
