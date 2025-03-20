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
import RxCocoa
import Foundation

public final class DefaultHistoryFilterViewModel: HistoryFilterViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    
    public func transform(input: FeatureHistoryInterfaces.HistoryFilterViewModelInput) -> FeatureHistoryInterfaces.HistoryFilterViewModelOutput {
        let filterType: BehaviorRelay<HistoryFilterType> = .init(value: .all)
        let years: BehaviorRelay<[Int]> = .init(value: Array(1970...Calendar.current.component(.year, from: Date())))
        let month: BehaviorRelay<[Int]> = .init(value: Array(1...12))
        
        input.segmentChanged
            .map { HistoryFilterType(rawValue: $0)! }
            .bind(to: filterType)
            .disposed(by: disposeBag)
        
        return .init(
            filterType: filterType.asDriver(),
            years: years.asDriver().map { $0.map {
                let df = DateFormatter()
                df.locale = .getLocaleFromLangCode()
                df.dateFormat = "yyyy"
                
                let year = df.string(from: df.date(from: "\($0)")!)
                switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
                case "en": return year
                case "vi": fallthrough
                case "th": return "\("Year".localized)\(year)"
                default: return "\(year)\("Year".localized)"
                }
            } },
            months: month.asDriver().map { $0.map {
                let df = DateFormatter()
                df.locale = .getLocaleFromLangCode()
                df.dateFormat = "MM"
                
                let month = df.string(from: df.date(from: "\($0)")!)
                switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
                case "en": return month
                case "vi": fallthrough
                case "th": return "\("Month".localized)\(month)"
                default: return "\(month)\("Month".localized)"
                }
            } }
        )
    }
}
