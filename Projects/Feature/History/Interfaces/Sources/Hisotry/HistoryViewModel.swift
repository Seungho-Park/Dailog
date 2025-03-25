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
import DomainDiaryInterfaces

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
    public let willDisplayCell: Observable<Int>
    
    public init(
        filterButtonTapped: Observable<Void>?,
        willDisplayCell: Observable<Int>
    ) {
        self.filterButtonTapped = filterButtonTapped
        self.willDisplayCell = willDisplayCell
    }
}

public struct HistoryViewModelOutput {
    
    public init(
        
    ) {
        
    }
}

public protocol HistoryViewModel: ViewModel where Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    var fetchDiariesUsecase: FetchDiariesUsecase { get }
    var actions: HistoryViewModelAction { get }
}
