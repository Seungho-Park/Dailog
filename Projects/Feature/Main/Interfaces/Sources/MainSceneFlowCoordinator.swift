//
//  MainSceneFlowCoordinator.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public protocol MainSceneFlowCoordinatorDependencies {
    
}

public protocol MainSceneFlowCoordinator: Coordinator {
    var dependencies: MainSceneFlowCoordinatorDependencies { get }
}
