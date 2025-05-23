//
//  DefaultDatePickerViewModel.swift
//  FeatureDiary
//
//  Created by 박승호 on 3/29/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import FeatureDiaryInterfaces

public final class DefaultDatePickerViewModel: DatePickerViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let date: Date
    public let actions: DatePickerAction
    
    public init(date: Date = Date(), actions: DatePickerAction) {
        self.date = date
        self.actions = actions
    }
    
    public func transform(input: FeatureDiaryInterfaces.DatePickerViewModelInput) -> FeatureDiaryInterfaces.DatePickerViewModelOutput {
        input.dismissAction
            .map { _-> Date? in return nil }
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        input.applyButtonTapped
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        return .init(
            date: Observable.just(date).asDriver(onErrorJustReturn: Date())
        )
    }
    
    
}
