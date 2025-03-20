//
//  HistoryViewModel.swift
//  FeatureCalendar
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift
import RxCocoa

public struct HistoryViewModelAction {
    public let showSelectFilter: ()-> Observable<HistoryFilterType?>
    
    public init(
        showSelectFilter: @escaping () -> Observable<HistoryFilterType?>
    ) {
        self.showSelectFilter = showSelectFilter
    }
}

public struct HistoryViewModelInput {
    public let filterButtonTapped: Observable<Void>?
    public init(
        filterButtonTapped: Observable<Void>?
    ) {
        self.filterButtonTapped = filterButtonTapped
    }
}

public struct HistoryViewModelOutput {
    
    
    public init(
        
    ) {
        
    }
}

public protocol HistoryViewModel: ViewModel where Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    var actions: HistoryViewModelAction { get }
}
