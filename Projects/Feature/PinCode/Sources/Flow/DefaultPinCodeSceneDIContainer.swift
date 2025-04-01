//
//  DefaultPinCodeSceneDIContainer.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import FeaturePinCodeInterfaces
import UIKit

public final class DefaultPinCodeSceneDIContainer: PinCodeSceneDIContainer {
    public let dependencies: FeaturePinCodeInterfaces.PinCodeSceneDIContainerDependencies
    
    public init(dependencies: PinCodeSceneDIContainerDependencies) {
        self.dependencies = dependencies
    }
    
    public func makePinCodeSceneFlowCoordinator(navigationController: UINavigationController) -> PinCodeSceneFlowCoordinator {
        return DefaultPinCodeSceneFlowCoordinator.init(navigationController: navigationController, dependencies: self)
    }
    
    public func makePinCodeViewModel(actions: PinCodeViewModelAction) -> any PinCodeViewModel {
        return DefaultPinCodeViewModel(actions: actions)
    }
}
