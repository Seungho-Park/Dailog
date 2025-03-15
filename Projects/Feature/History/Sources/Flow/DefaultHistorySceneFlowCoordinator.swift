//
//  DefaultHistorySceneFlowCoordinator.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureHistoryInterfaces
import SharedUI

public final class DefaultHistorySceneFlowCoordinator: HistorySceneFlowCoordinator {
    public var dependencies: any HistorySceneFlowCoordinatorDependencies
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: any HistorySceneFlowCoordinatorDependencies) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return HistoryScene.history(dependencies.makeHistoryViewModel()).instantiate()
    }
}
