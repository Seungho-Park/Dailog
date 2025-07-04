import UIKit
import SharedUI

public protocol HistorySceneFlowCoordinatorDependencies {
    
}

public protocol HistorySceneFlowCoordinator: Coordinator {
    var dependencies: HistorySceneFlowCoordinatorDependencies { get }
}
