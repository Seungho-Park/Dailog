//
//  DefaultHistoryFilterViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces
import FeatureHistoryInterfaces
import RxSwift
import RxCocoa
import Foundation

public final class DefaultHistoryFilterViewModel: HistoryFilterViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let actions: HistoryFilterViewModelAction
    
    public init(actions: HistoryFilterViewModelAction) {
        self.actions = actions
    }
    
    public func transform(input: FeatureHistoryInterfaces.HistoryFilterViewModelInput) -> FeatureHistoryInterfaces.HistoryFilterViewModelOutput {
        let filterType: BehaviorRelay<HistoryFilterType> = .init(value: .all)
        let years: BehaviorRelay<[Int]> = .init(value: Array(1970...Calendar.current.component(.year, from: Date())))
        let month: BehaviorRelay<[Int]> = .init(value: Array(1...12))
        
        let selectedYear: BehaviorRelay<Int> = .init(value: years.value.count-1)
        let selectedMonth: BehaviorRelay<Int> = .init(value: month.value.count-1)
        
        input.segmentChanged
            .map {
                if $0 == 0 { return HistoryFilterType.all }
                else if $0 == 1 { return HistoryFilterType.year(years.value[selectedYear.value]) }
                else { return HistoryFilterType.month(years.value[selectedYear.value], month.value[selectedMonth.value]) }
            }
            .bind(to: filterType)
            .disposed(by: disposeBag)
        
        return .init(
            filterType: filterType.asDriver(),
            years: years.asDriver(),
            months: month.asDriver()
        )
    }
    
    private func toFormatString(year: Int?, month: Int?)-> String {
        if year == nil && month == nil { return "All".localized }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.getLocaleFromLangCode()
        dateFormatter.dateFormat = month == nil ? "yyyy" : "yyyy-MM"
        let date = dateFormatter.date(from: month == nil ? "\(year!)" : "\(year!)-\(String(format: "%02d", month!))")
        
        if month == nil {
            dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
        } else {
            if dateFormatter.locale.identifier.hasPrefix("en") {
                dateFormatter.dateFormat = "MMMM, yyyy"
            } else {
                dateFormatter.setLocalizedDateFormatFromTemplate("yyyy MMMM")
            }
        }
        
        return dateFormatter.string(from: date!)
    }
}
