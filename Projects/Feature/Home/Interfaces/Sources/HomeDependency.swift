import UIKit
import NeedleFoundation

public protocol HomeDependency: Dependency {
    var navigationController: UINavigationController { get }
}

public protocol HomeBuilder {
    func makeHomeSceneFlowCoordinator(dependencies: HomeSceneFlowCoordinatorDependencies)-> HomeSceneFlowCoordinator
    
    func makeHomeViewController(action: HomeViewModelAction)-> HomeViewController
}
