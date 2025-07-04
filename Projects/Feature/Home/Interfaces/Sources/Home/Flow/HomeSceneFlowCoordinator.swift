import UIKit
import SharedUI

public protocol HomeSceneFlowCoordinatorDependencies {
    
}

public protocol HomeSceneFlowCoordinator: Coordinator {
    var dependencies: HomeSceneFlowCoordinatorDependencies { get }
}
