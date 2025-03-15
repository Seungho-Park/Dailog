//
//  DefaultHistoryViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import SharedUIInterfaces
import FeatureHistoryInterfaces

public final class DefaultHistoryViewModel: HistoryViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let navigationBarStyle: NavigationBarStyle = .filter
    
    public func transform(input: FeatureHistoryInterfaces.HistoryViewModelInput) -> FeatureHistoryInterfaces.HistoryViewModelOutput {
        return .init()
    }
}
