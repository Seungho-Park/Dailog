import NeedleFoundation

public final class HistoryComponent: Component<HistoryDependency>, HistoryBuilder {
    public var coordinator: any HistorySceneFlowCoordinator {
        return DefaultHistorySceneFlowCoordinator(navigationController: dependency.navigationController, builder: self)
    }
}
