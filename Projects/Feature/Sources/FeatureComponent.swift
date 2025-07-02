//
//  FeatureComponent.swift
//  Feature
//
//  Created by 박승호 on 6/30/25.
//

import SharedApp

public protocol FeatureDependency: Dependency {
    
}

public protocol FeatureBuilder {
    var coordinator: FeatureFlowCoordinator { get }
    var splashViewController: SplashViewController { get }
}

public final class FeatureComponent: Component<FeatureDependency>, FeatureBuilder {
    public override init(parent: any Scope) {
        super.init(parent: parent)
        
    }
    
    public var navigationController: UINavigationController {
        shared {
            let navController = UINavigationController()
            navController.navigationBar.isHidden = true
            return navController
        }
    }
    
    public var coordinator: FeatureFlowCoordinator {
        shared {
            FeatureFlowCoordinator(
                navigationController: navigationController,
                builder: self
            )
        }
    }
    
    public var splashViewController: SplashViewController {
        return SplashViewController.create(viewModel: .init())
    }
}
