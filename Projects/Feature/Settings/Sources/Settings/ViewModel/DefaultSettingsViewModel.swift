//
//  SettingsViewModel.swift
//  FeatureSettings
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import FeatureSettingsInterfaces
import SharedUIInterfaces

public final class DefaultSettingsViewModel: SettingsViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let actions: SettingsViewModelAction
    
    public init(actions: SettingsViewModelAction) {
        self.actions = actions
    }
    
    public func transform(input: SettingsViewModelInput) -> SettingsViewModelOutput {
        
        actions.showPinCodeScene(false)
        
        return .init()
    }
}
