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

public enum HistoryFilterType: Int {
    case all
    case year
    case month
    
//    public func toDateString()-> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale.getLocaleFromLangCode()
//        switch self {
//        case .all: return "All".localized
//        case .year(let year):
//            
//        case .month(let year, let month):
//            dateFormatter.dateFormat = "yyyy-M"
//            let date = dateFormatter.date(from: "\(year)-\(month)")
//            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy MMMM")
//            return dateFormatter.string(from: date!)
//        }
//    }
}

public struct HistoryFilterViewModelAction {
    
    public init() {
        
    }
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
    public let years: Driver<[Int]>
    public let months: Driver<[Int]>
    
    public init(
        filterType: Driver<HistoryFilterType>,
        years: Driver<[Int]>,
        months: Driver<[Int]>
    ) {
        self.filterType = filterType
        self.years = years
        self.months = months
    }
}

public protocol HistoryFilterViewModel: ViewModel where Input == HistoryFilterViewModelInput, Output == HistoryFilterViewModelOutput {
    var actions: HistoryFilterViewModelAction { get }
}
