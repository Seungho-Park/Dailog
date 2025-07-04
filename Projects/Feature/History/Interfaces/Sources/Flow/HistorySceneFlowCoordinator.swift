import UIKit
import SharedUI

public protocol HistorySceneFlowCoordinatorDependencies: AnyObject {
    
}

public protocol HistorySceneFlowCoordinator: Coordinator {
    var dependencies: HistorySceneFlowCoordinatorDependencies? { get }
}
