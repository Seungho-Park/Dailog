//
//  DefaultReminderViewModel.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import FeatureReminderInterfaces
import DomainDiaryInterfaces

public final class DefaultReminderViewModel: ReminderViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    
    public let fetchDiariesUsecase: FetchDiariesUsecase
    
    init(
        fetchDiariesUsecase: FetchDiariesUsecase
    ) {
        self.fetchDiariesUsecase = fetchDiariesUsecase
    }
    
    public func transform(input: ReminderViewModelInput) -> ReminderViewModelOutput {
        let date: BehaviorRelay<Date> = .init(value: .now)
        
        Observable.merge(
            input.nextDateButtonTapped.map { 1 },
            input.prevDateButtonTapped.map { -1 }
        )
        .compactMap {
            Calendar.current.date(byAdding: .month, value: $0, to: date.value)
        }
        .bind(to: date)
        .disposed(by: disposeBag)
        
        return .init(
            date: date.asDriver().map {
                let df = DateFormatter()
                df.locale = Locale.getLocaleFromLangCode()
                df.setLocalizedDateFormatFromTemplate("yyyy MMM")
                return df.string(from: $0)
            }
        )
    }
}
