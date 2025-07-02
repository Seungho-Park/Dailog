//
//  SplashViewModel.swift
//  Feature
//
//  Created by 박승호 on 7/2/25.
//

import Foundation
import SharedUI

public struct SplashViewModelAction {
    public let showMainTabBarScene: ()-> Void
    
    public init(
        showMainTabBarScene: @escaping ()-> Void
    ) {
        self.showMainTabBarScene = showMainTabBarScene
    }
}

public struct SplashViewModelInput {
    
    public init() {
        
    }
}

public struct SplashViewModelOutput {
    
    public init() {
        
    }
}

public final class SplashViewModel: ViewModel {
    public var action: SplashViewModelAction
    
    public init(action: SplashViewModelAction) {
        self.action = action
    }
    
    public func transform(input: SplashViewModelInput) -> SplashViewModelOutput {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.action.showMainTabBarScene()
        }
        
        return .init()
    }
}
