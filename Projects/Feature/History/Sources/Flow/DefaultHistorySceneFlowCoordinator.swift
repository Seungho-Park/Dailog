import UIKit
import SharedUI

public final class DefaultHistorySceneFlowCoordinator: HistorySceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: HistoryBuilder
    
    public init(
        navigationController: UINavigationController,
        builder: HistoryBuilder
    ) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return builder.makeHistoryViewController(action: .init())
    }
}
