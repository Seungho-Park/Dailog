//
//  DefaultReminderViewModel.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import FeatureReminderInterfaces

public final class DefaultReminderViewModel: ReminderViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    
    public func transform(input: ReminderViewModelInput) -> ReminderViewModelOutput {
        return .init()
    }
}
