//
//  HistoryFilterViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift
import RxCocoa

public enum HistoryFilterType: Int {
    case all = 0
    case year
    case month
}

public struct HistoryFilterViewModelInput {
    public let segmentChanged: Observable<Int>
    public let didSelectedPicker: Observable<(row: Int, component: Int)>
    public let applyButtonTapped: Observable<Void>
    
    public init(
        segmentChanged: Observable<Int>,
        didSelectedPicker: Observable<(row: Int, component: Int)>,
        applyButtonTapped: Observable<Void>
    ) {
        self.segmentChanged = segmentChanged
        self.didSelectedPicker = didSelectedPicker
        self.applyButtonTapped = applyButtonTapped
    }
}

public struct HistoryFilterViewModelOutput {
    public let filterType: Driver<HistoryFilterType>
    public let years: Driver<[String]>
    public let months: Driver<[String]>
    
    public init(
        filterType: Driver<HistoryFilterType>,
        years: Driver<[String]>,
        months: Driver<[String]>
    ) {
        self.filterType = filterType
        self.years = years
        self.months = months
    }
}

public protocol HistoryFilterViewModel: ViewModel where Input == HistoryFilterViewModelInput, Output == HistoryFilterViewModelOutput {
    
}
