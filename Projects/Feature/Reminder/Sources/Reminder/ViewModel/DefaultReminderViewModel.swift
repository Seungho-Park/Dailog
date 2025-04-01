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
        let diaries: BehaviorRelay<[Diary]> = .init(value: [])
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
        
        input.viewWillAppear
            .flatMapLatest {
                date
            }
            .withUnretained(self)
            .flatMap { owner, date in
                owner.fetchDiariesUsecase.execute(year: Calendar.current.component(.year, from: date), month: Calendar.current.component(.month, from: date), page: 1, count: 0)
                    .catchAndReturn(.init(currentPage: 1, totalPages: 1, diaries: []))
            }
            .map { $0.diaries }
            .bind(to: diaries)
            .disposed(by: disposeBag)
        
        return .init(
            date: date.asDriver().map {
                let df = DateFormatter()
                df.locale = Locale.getLocaleFromLangCode()
                df.setLocalizedDateFormatFromTemplate("yyyy MMM")
                return df.string(from: $0)
            },
            diaries: diaries.asDriver(),
            emotion: diaries.map { diaries in
                var emotions: [Emotion:Int] = [:]
                for diary in diaries {
                    guard let emotion = diary.emotion else { continue }
                    emotions[emotion, default: 0] += 1
                }
                return emotions
            }.asDriver(onErrorJustReturn: [:])
        )
    }
}
