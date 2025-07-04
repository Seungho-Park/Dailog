import UIKit
import SharedUI

public final class DefaultSettingsSceneFlowCoordinator: SettingsSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: SettingsBuilder
    
    public init(
        navigationController: UINavigationController,
        builder: SettingsBuilder
    ) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return builder.makeSettingsViewController()
    }
}
