import UIKit
import SharedUI

public final class DefaultHistorySceneFlowCoordinator: HistorySceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: HistoryBuilder
    public let dependencies: HistorySceneFlowCoordinatorDependencies
    
    public init(
        navigationController: UINavigationController,
        builder: HistoryBuilder,
        dependencies: HistorySceneFlowCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.builder = builder
        self.dependencies = dependencies
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return builder.makeHistoryViewController(action: .init())
    }
}
