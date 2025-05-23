//
//  SettingsViewModel.swift
//  FeatureSettings
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct SettingsViewModelAction {
    public let showPinCodeScene: (Bool)-> Void
    
    public init(
        showPinCodeScene: @escaping (Bool)-> Void
    ) {
        self.showPinCodeScene = showPinCodeScene
    }
}

public struct SettingsViewModelInput {
    public init() {  }
}

public struct SettingsViewModelOutput {
    
    public init() {  }
}

public protocol SettingsViewModel: ViewModel where Input == SettingsViewModelInput, Output == SettingsViewModelOutput {
    
    var actions: SettingsViewModelAction { get }
}
