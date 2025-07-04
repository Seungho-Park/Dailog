import UIKit
import SharedUI

public final class DefaultDiarySceneFlowCoordinator: DiarySceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let builder: DiaryBuilder
    
    public init(
        navigationController: UINavigationController,
        builder: DiaryBuilder
    ) {
        self.navigationController = navigationController
        self.builder = builder
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return .init()
    }
}
