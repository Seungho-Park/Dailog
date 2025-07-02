import NeedleFoundation

public final class HomeComponent: Component<HomeDependency>, HomeBuilder {
    public var coordinator: any HomeSceneFlowCoordinator {
        return DefaultHomeSceneFlowCoordinator(navigationController: dependency.navigationController, builder: self)
    }
}
