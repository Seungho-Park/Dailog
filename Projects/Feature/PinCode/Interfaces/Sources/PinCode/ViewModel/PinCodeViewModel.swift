//
//  PinCodeViewModel.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift
import RxCocoa

public struct PinCodeViewModelAction {
    public let close: (String?)-> Void
    
    public init(
        close: @escaping (String?)-> Void
    ) {
        self.close = close
    }
}

public struct PinCodeViewModelInput {
    public let pinNumberPadTapped: Observable<Int>
    
    public init(
        pinNumberPadTapped: Observable<Int>
    ) {
        self.pinNumberPadTapped = pinNumberPadTapped
    }
}

public struct PinCodeViewModelOutput {
    public let pinNumber: Driver<String>
    
    public init(
        pinNumber: Driver<String>
    ) {
        self.pinNumber = pinNumber
    }
}

public protocol PinCodeViewModel: ViewModel where Input == PinCodeViewModelInput, Output == PinCodeViewModelOutput {
    var actions: PinCodeViewModelAction { get }
}
