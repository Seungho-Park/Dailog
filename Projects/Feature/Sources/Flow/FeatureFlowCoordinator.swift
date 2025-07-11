//
//  FeatureFlowCoordinator.swift
//  Feature
//
//  Created by 박승호 on 6/30/25.
//

import UIKit
import SharedUI

public final class FeatureFlowCoordinator: Coordinator {
    public let navigationController: UINavigationController
    private let builder: FeatureBuilder
    
    public init(navigationController: UINavigationController, builder: FeatureBuilder) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    @discardableResult
    public func start() -> UIViewController {
        transition(
            builder.makeSplashViewController(
                action: .init(
                    showMainTabBarScene: showMainTabBarScene
                )
            ),
            style: .root,
            animated: true
        )
        
        return navigationController
    }
    
    private func showMainTabBarScene() {
        transition(builder.makeMainTabBarViewController(action: .init()), style: .root)
    }
}
