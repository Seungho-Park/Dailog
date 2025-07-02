//
//  MainTabBarViewModel.swift
//  Feature
//
//  Created by 박승호 on 7/2/25.
//

import SharedUI

public struct MainTabBarViewModelAction {
    
    public init() {
        
    }
}

public struct MainTabBarViewModelInput {
    
    public init() {
        
    }
}

public struct MainTabBarViewModelOutput {
    
    public init() {
        
    }
}

public final class MainTabBarViewModel: ViewModel {
    public var action: MainTabBarViewModelAction
    
    public init(action: MainTabBarViewModelAction) {
        self.action = action
    }
    
    public func transform(input: MainTabBarViewModelInput) -> MainTabBarViewModelOutput {
        return .init()
    }
}
