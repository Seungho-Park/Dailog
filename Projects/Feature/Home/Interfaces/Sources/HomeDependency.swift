import UIKit
import NeedleFoundation

public protocol HomeDependency: Dependency {
    var navigationController: UINavigationController { get }
}

public protocol HomeBuilder {
    var coordinator: HomeSceneFlowCoordinator { get }
    
    func makeHomeViewController(action: HomeViewModelAction)-> HomeViewController
}
