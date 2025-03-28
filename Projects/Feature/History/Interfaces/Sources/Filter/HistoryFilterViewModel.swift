//
//  HistoryFilterViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces
import SharedUI
import RxSwift
import RxCocoa

public enum HistoryFilterType {
    case all
    case year(Int)
    case month(Int, Int)
}

public struct HistoryFilterViewModelAction {
    public let selectFilter: (HistoryFilterType?)-> Void
    
    public init(selectFilter: @escaping (HistoryFilterType?)-> Void) {
        self.selectFilter = selectFilter
    }
}

public struct HistoryFilterViewModelInput {
    public let outsideTapped: Observable<Void>
    public let applyButtonTapped: Observable<HistoryFilterType>
    
    public init(
        outsideTapped: Observable<Void>,
        applyButtonTapped: Observable<HistoryFilterType>
    ) {
        self.outsideTapped = outsideTapped
        self.applyButtonTapped = applyButtonTapped
    }
}

public struct HistoryFilterViewModelOutput {
    public let years: Driver<[Int]>
    public let months: Driver<[Int]>
    
    public init(
        years: Driver<[Int]>,
        months: Driver<[Int]>
    ) {
        self.years = years
        self.months = months
    }
}

public protocol HistoryFilterViewModel: ViewModel where Input == HistoryFilterViewModelInput, Output == HistoryFilterViewModelOutput {
    var actions: HistoryFilterViewModelAction { get }
}
