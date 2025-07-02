import UIKit
import SharedUI

public final class DefaultHomeSceneFlowCoordinator: HomeSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: HomeBuilder
    
    public init(
        navigationController: UINavigationController,
        builder: HomeBuilder
    ) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return .init()
    }
}
