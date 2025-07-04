import NeedleFoundation

public final class HistoryComponent: Component<HistoryDependency>, HistoryBuilder {
    public func makeHistorySceneFlowCoordinator(dependencies: any HistorySceneFlowCoordinatorDependencies) -> any HistorySceneFlowCoordinator {
        return DefaultHistorySceneFlowCoordinator(navigationController: dependency.navigationController, builder: self, dependencies: dependencies)
    }
    
    public func makeHistoryViewController(action: HistoryViewModelAction) -> any HistoryViewController {
        let vc = DefaultHistoryViewController.create(viewModel: DefaultHistoryViewModel(action: action))
        vc.tabBarItem = .init(title: "History".localized, image: nil, tag: 1)
        return vc
    }
}
