//
//  DefaultMainStore.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import ComposableArchitecture
import FeatureMainInterfaces

public struct DefaultMainStore: MainStore {
    public init() {  }
    
    public var reduce: Reduce<MainState, MainAction> {
        Reduce { state, action in
            return .none
        }
    }
}
