//
//  PhotoSceneDIContainer.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct PhotoSceneDIContainerDependencies {
    public let type: PhotoScene
}

public protocol PhotoSceneDIContainer: DIContainer, PhotoSceneFlowCoordinatorDependencies {
    
}
