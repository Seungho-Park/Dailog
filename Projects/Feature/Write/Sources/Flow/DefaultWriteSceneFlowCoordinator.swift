//
//  DefaultWriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureWriteInterfaces

public final class DefaultWriteSceneFlowCoordinator: WriteSceneFlowCoordinator {
    public var dependencies: WriteSceneFlowCoordinatorDependencies
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: WriteSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        transition(
            scene: DiaryWriteScene.write(
                dependencies.makeDiaryWriteViewModel(
                    emotion: nil,
                    actions: .init(
                        showSelectEmotion: showSelectEmotionScene
                    )
                )
            ),
            transitionStyle: .push,
            animated: true
        )
    }
    
    public func showSelectEmotionScene() {
        transition(
            scene: DiaryWriteScene.emotion(
                dependencies.makeEmotionViewModel(
                    actions: .init(
                        selectEmotion: { _ in }
                    )
                )
            ),
            transitionStyle: .modal,
            animated: true
        )
    }
}
