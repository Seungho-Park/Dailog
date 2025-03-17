//
//  WriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public protocol WriteSceneFlowCoordinatorDependencies {
    
}

public protocol WriteSceneFlowCoordinator: Coordinator {
    var dependencies: WriteSceneFlowCoordinatorDependencies { get }
    
    func showSelectEmotionScene()
}
