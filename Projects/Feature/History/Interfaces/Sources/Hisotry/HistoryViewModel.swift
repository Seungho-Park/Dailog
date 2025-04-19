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
    public let showSelectFilter: (HistoryFilterType)-> Observable<HistoryFilterType?>
    public let showWriteDiaryScene: ()-> Void
    public let showDiaryDetailScene: (Diary)-> Void
    
    public init(
        showSelectFilter: @escaping (HistoryFilterType) -> Observable<HistoryFilterType?>,
        showWriteDiaryScene: @escaping ()-> Void,
        showDiaryDetailScene: @escaping (Diary)-> Void
    ) {
        self.showSelectFilter = showSelectFilter
        self.showWriteDiaryScene = showWriteDiaryScene
        self.showDiaryDetailScene = showDiaryDetailScene
    }
}

public struct HistoryViewModelInput {
    public let viewWillAppear: Observable<Void>
    public let filterButtonTapped: Observable<Void>?
    public let willDisplayCell: Observable<Int>
    public let writeDiaryButtonTapped: Observable<Void>
    public let diaryItemTapped: Observable<DiaryListItemViewModel>
    
    public init(
        viewWillAppear: Observable<Void>,
        filterButtonTapped: Observable<Void>?,
        willDisplayCell: Observable<Int>,
        writeDiaryButtonTapped: Observable<Void>,
        diaryItemTapped: Observable<DiaryListItemViewModel>
    ) {
        self.viewWillAppear = viewWillAppear
        self.filterButtonTapped = filterButtonTapped
        self.willDisplayCell = willDisplayCell
        self.writeDiaryButtonTapped = writeDiaryButtonTapped
        self.diaryItemTapped = diaryItemTapped
    }
}

public struct HistoryViewModelOutput {
    public let items: Driver<[DiaryListItemViewModel]>
    public let filter: Driver<String>
    
    public init(
        items: Driver<[DiaryListItemViewModel]>,
        filter: Driver<String>
    ) {
        self.items = items
        self.filter = filter
    }
}

public protocol HistoryViewModel: ViewModel where Input == HistoryViewModelInput, Output == HistoryViewModelOutput {
    var fetchDiariesUsecase: FetchDiariesUsecase { get }
    var fetchPhotoDataUsecase: FetchPhotoDataUsecase { get }
    var actions: HistoryViewModelAction { get }
}
