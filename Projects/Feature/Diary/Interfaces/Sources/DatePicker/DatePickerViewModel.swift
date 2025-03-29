//
//  DatePickerViewModel.swift
//  FeatureDiary
//
//  Created by 박승호 on 3/29/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SharedUIInterfaces

public struct DatePickerAction {
    public let close: (Date?)-> Void
    
    public init(close: @escaping (Date?) -> Void) {
        self.close = close
    }
}

public struct DatePickerViewModelInput {
    public let dismissAction: Observable<Void>
    public let applyButtonTapped: Observable<Date>
    
    public init(
        dismissAction: Observable<Void>,
        applyButtonTapped: Observable<Date>
    ) {
        self.dismissAction = dismissAction
        self.applyButtonTapped = applyButtonTapped
    }
}

public struct DatePickerViewModelOutput {
    public let date: Driver<Date>
    
    public init(date: Driver<Date>) {
        self.date = date
    }
}

public protocol DatePickerViewModel: ViewModel where Input == DatePickerViewModelInput, Output == DatePickerViewModelOutput {
    var date: Date { get }
    var actions: DatePickerAction { get }
}
