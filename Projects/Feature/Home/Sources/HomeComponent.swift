import NeedleFoundation

public final class HomeComponent: Component<HomeDependency>, HomeBuilder {
    
    public func makeHomeSceneFlowCoordinator(dependencies: any HomeSceneFlowCoordinatorDependencies) -> any HomeSceneFlowCoordinator {
        return DefaultHomeSceneFlowCoordinator(navigationController: dependency.navigationController, builder: self, dependencies: dependencies)
    }
    
    public func makeHomeViewController(action: HomeViewModelAction) -> any HomeViewController {
        let vc = DefaultHomeViewController.create(viewModel: DefaultHomeViewModel(action: action))
        vc.tabBarItem = .init(title: "Home".localized, image: nil, tag: 0)
        return vc
    }
}
