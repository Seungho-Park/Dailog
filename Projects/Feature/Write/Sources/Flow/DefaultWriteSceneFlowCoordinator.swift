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
        let vc = DiaryWriteViewController.create(
            viewModel: DefaultDiaryWriteViewModel(
                emotion: nil,
                actions: .init(
                    showSelectEmotion: showSelectEmotionScene
                )
            )
        )
        navigationController.pushViewController(vc, animated: true)
        return vc
    }
    
    public func showSelectEmotionScene() {
        let vc = EmotionViewController.create(viewModel: DefaultEmotionViewModel())
        vc.view.backgroundColor = .white
        navigationController.topViewController?.present(vc, animated: true)
    }
}
