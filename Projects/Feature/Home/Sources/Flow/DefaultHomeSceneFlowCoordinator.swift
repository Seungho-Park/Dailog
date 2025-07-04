import UIKit
import SharedUI

public final class DefaultHomeSceneFlowCoordinator: HomeSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: HomeBuilder
    public let dependencies: HomeSceneFlowCoordinatorDependencies
    
    public init(
        navigationController: UINavigationController,
        builder: HomeBuilder,
        dependencies: HomeSceneFlowCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.builder = builder
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return builder.makeHomeViewController(action: .init())
    }
}
