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
        let years: BehaviorRelay<[Int]> = .init(value: Array(1970...Calendar.current.component(.year, from: Date())))
        let month: BehaviorRelay<[Int]> = .init(value: Array(1...12))
        
        input.outsideTapped
            .map { _-> HistoryFilterType? in
                return nil
            }
            .bind(onNext: actions.selectFilter)
            .disposed(by: disposeBag)
        
        input.applyButtonTapped
            .bind(onNext: actions.selectFilter)
            .disposed(by: disposeBag)
        
        return .init(
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
