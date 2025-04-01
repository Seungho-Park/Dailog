//
//  DefaultPinCodeViewModel.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SharedUI
import SharedUIInterfaces
import FeaturePinCodeInterfaces

public final class DefaultPinCodeViewModel: PinCodeViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let actions: PinCodeViewModelAction
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public init(actions: PinCodeViewModelAction) {
        self.actions = actions
    }
    
    public func transform(input: PinCodeViewModelInput) -> PinCodeViewModelOutput {
        let pinNumber: BehaviorRelay<String> = .init(value: "")
        
        input.pinNumberPadTapped
            .map { value-> String? in
                let number = pinNumber.value
                if value == -1 && number.isEmpty { return "" }
                else if value == -99 { return nil }
                else {
                    if value == -1 { return String(number.prefix(number.count-1)) }
                    else {
                        if number.count == 4 { return number }
                        return "\(number)\(value)"
                    }
                }
            }
            .withUnretained(self)
            .compactMap { owner, pin in
                if pin == nil {
                    owner.actions.close(nil)
                }
                
                return pin
            }
            .bind(to: pinNumber)
            .disposed(by: disposeBag)
        
        return .init(
            pinNumber: pinNumber.asDriver()
        )
    }
}
