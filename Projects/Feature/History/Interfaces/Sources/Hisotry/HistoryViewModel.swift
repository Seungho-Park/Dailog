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
import DomainPhotoInterfaces

public struct HistoryViewModelAction {
    public let showSelectFilter: ()-> Observable<HistoryFilterType?>
    
    public init(
        showSelectFilter: @escaping () -> Observable<HistoryFilterType?>
    ) {
        self.showSelectFilter = showSelectFilter
    }
}

public struct HistoryViewModelInput {
    public let viewWillAppear: Observable<Void>
    public let filterButtonTapped: Observable<Void>?
    public let willDisplayCell: Observable<Int>
    
    public init(
        viewWillAppear: Observable<Void>,
        filterButtonTapped: Observable<Void>?,
        willDisplayCell: Observable<Int>
    ) {
        self.viewWillAppear = viewWillAppear
        self.filterButtonTapped = filterButtonTapped
        self.willDisplayCell = willDisplayCell
    }
}

public struct HistoryViewModelOutput {
    public let items: Driver<[DiaryListItemViewModel]>
    
    public init(
        items: Driver<[DiaryListItemViewModel]>
    ) {
        self.items = items
    }
}

public protocol HistoryViewModel: ViewModel where Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    var fetchDiariesUsecase: FetchDiariesUsecase { get }
    var fetchPhotoDataUsecase: FetchPhotoDataUsecase { get }
    var actions: HistoryViewModelAction { get }
}
