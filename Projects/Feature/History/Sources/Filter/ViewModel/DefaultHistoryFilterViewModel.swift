//
//  DefaultHistoryFilterViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import FeatureHistoryInterfaces
import RxSwift

public final class DefaultHistoryFilterViewModel: HistoryFilterViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let navigationBarStyle: NavigationBarStyle = .none
    
    public func transform(input: FeatureHistoryInterfaces.HistoryFilterViewModelInput) -> FeatureHistoryInterfaces.HistoryFilterViewModelOutput {
        
        return .init()
    }
}
