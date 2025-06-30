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
}

public final class FeatureComponent: Component<FeatureDependency>, FeatureBuilder {
    public override init(parent: any Scope) {
        super.init(parent: parent)
        print("12341234")
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
}
