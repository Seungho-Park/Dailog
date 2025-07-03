import UIKit
import NeedleFoundation

public protocol HistoryDependency: Dependency {
    var navigationController: UINavigationController { get }
}

public protocol HistoryBuilder {
    var coordinator: HistorySceneFlowCoordinator { get }
    
    func makeHistoryViewController(action: HistoryViewModelAction)-> HistoryViewController
}
