import UIKit
import SharedUI

public protocol HomeSceneFlowCoordinatorDependencies: AnyObject {
    
}

public protocol HomeSceneFlowCoordinator: Coordinator {
    var dependencies: HomeSceneFlowCoordinatorDependencies? { get }
}
