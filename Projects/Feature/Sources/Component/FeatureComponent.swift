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
    
    func makeSplashViewController(action: SplashViewModelAction)-> SplashViewController
    func makeMainTabBarViewController(action: MainTabBarViewModelAction)-> MainTabBarViewController
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
    
    public func makeSplashViewController(action: SplashViewModelAction)-> SplashViewController {
        return SplashViewController.create(viewModel: .init(action: action))
    }
    
    public func makeMainTabBarViewController(action: MainTabBarViewModelAction) -> MainTabBarViewController {
        let vc = MainTabBarViewController.create(viewModel: .init(action: action))
        vc.viewControllers = [
            homeBuilder.makeHomeSceneFlowCoordinator(dependencies: self).start(),
            historyBuilder.makeHistorySceneFlowCoordinator(dependencies: self).start(),
            settingsBuilder.makeSettingsSceneFlowCoordinator().start()
        ]
        return vc
    }
}


// MARK: - Builder
extension FeatureComponent {
    public var homeBuilder: HomeBuilder {
        shared {
            HomeComponent(parent: self)
        }
    }
    
    public var historyBuilder: HistoryBuilder {
        shared {
            HistoryComponent(parent: self)
        }
    }
    
    public var settingsBuilder: SettingsBuilder {
        shared {
            SettingsComponent(parent: self)
        }
    }
    
    public var diaryBuilder: DiaryBuilder {
        shared {
            DiaryComponent(parent: self)
        }
    }
}
