//
//  PinCodeFlowCoordinator.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public protocol PinCodeSceneFlowCoordinatorDependencies {
    func makePinCodeViewModel(actions: PinCodeViewModelAction)-> any PinCodeViewModel
}

public protocol PinCodeSceneFlowCoordinator: Coordinator {
    var dependencies: PinCodeSceneFlowCoordinatorDependencies { get }
}
