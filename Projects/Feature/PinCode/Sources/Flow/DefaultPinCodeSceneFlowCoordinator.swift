//
//  DefaultPinCodeSceneFlowCoordinator.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeaturePinCodeInterfaces

public final class DefaultPinCodeSceneFlowCoordinator: PinCodeSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let dependencies: PinCodeSceneFlowCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: PinCodeSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        transition(
            scene: PinCodeScene.pinCode(
                dependencies.makePinCodeViewModel(
                    actions: .init(
                        close: close(pinNumber:)
                    )
                )
            ),
            transitionStyle: .push,
            animated: true
        )
    }
    
    private func close(pinNumber: String?) {
        close(animated: true)
    }
}
