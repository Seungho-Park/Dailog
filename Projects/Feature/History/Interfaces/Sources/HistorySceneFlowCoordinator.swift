//
//  HistorySceneFlowCoordinator.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public protocol HistorySceneFlowCoordinatorDependencies {
    
}

public protocol HistorySceneFlowCoordinator: Coordinator {
    var dependencies: HistorySceneFlowCoordinatorDependencies { get }
}
