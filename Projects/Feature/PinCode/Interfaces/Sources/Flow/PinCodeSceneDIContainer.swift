//
//  PinCodeSceneDIContainer.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public struct PinCodeSceneDIContainerDependencies {
    
    public init() {  }
}

public protocol PinCodeSceneDIContainer: PinCodeSceneFlowCoordinatorDependencies {
    var dependencies: PinCodeSceneDIContainerDependencies { get }
    
    func makePinCodeSceneFlowCoordinator(navigationController: UINavigationController)-> PinCodeSceneFlowCoordinator
}
