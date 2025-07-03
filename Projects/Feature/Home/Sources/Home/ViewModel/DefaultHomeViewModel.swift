//
//  DefaultHomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 7/3/25.
//

public final class DefaultHomeViewModel: HomeViewModel {
    public let action: HomeViewModelAction
    
    public init(action: HomeViewModelAction) {
        self.action = action
    }
    
    public func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        return .init()
    }
}
