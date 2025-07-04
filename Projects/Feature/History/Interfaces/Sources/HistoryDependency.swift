import UIKit
import NeedleFoundation

public protocol HistoryDependency: Dependency {
    var navigationController: UINavigationController { get }
}

public protocol HistoryBuilder {
    func makeHistorySceneFlowCoordinator(dependencies: HistorySceneFlowCoordinatorDependencies)-> HistorySceneFlowCoordinator
    func makeHistoryViewController(action: HistoryViewModelAction)-> HistoryViewController
}
