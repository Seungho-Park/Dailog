//
//  WriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct WriteSceneDIContainerDependencies {
    public let photoSceneDIContainer: ()-> any DIContainer
    
    public init(photoSceneDIContainer: @escaping () -> any DIContainer) {
        self.photoSceneDIContainer = photoSceneDIContainer
    }
}

public protocol WriteSceneDIContainer: DIContainer, WriteSceneFlowCoordinatorDependencies {
    var dependencies: WriteSceneDIContainerDependencies { get }
}
