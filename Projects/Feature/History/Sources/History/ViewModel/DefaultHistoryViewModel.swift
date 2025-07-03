//
//  DefaultHistoryViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 7/3/25.
//

public final class DefaultHistoryViewModel: HistoryViewModel {
    public let action: HistoryViewModelAction
    
    public init(action: HistoryViewModelAction) {
        self.action = action
    }
    
    public func transform(input: HistoryViewModelInput) -> HistoryViewModelOutput {
        return .init()
    }
}
