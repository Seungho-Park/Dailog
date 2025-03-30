//
//  ReminderViewModel.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import SharedUIInterfaces
import DomainDiaryInterfaces

public struct ReminderViewModelInput {
    public let prevDateButtonTapped: Observable<Void>
    public let nextDateButtonTapped: Observable<Void>
    
    public init(
        prevDateButtonTapped: Observable<Void>,
        nextDateButtonTapped: Observable<Void>
    ) {
        self.prevDateButtonTapped = prevDateButtonTapped
        self.nextDateButtonTapped = nextDateButtonTapped
    }
}

public struct ReminderViewModelOutput {
    public let date: Driver<String>
    
    public init(
        date: Driver<String>
    ) {
        self.date = date
    }
}

public protocol ReminderViewModel: ViewModel where Input == ReminderViewModelInput, Output == ReminderViewModelOutput {
    var fetchDiariesUsecase: FetchDiariesUsecase { get }
}
