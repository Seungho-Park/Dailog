import UIKit
import NeedleFoundation

public protocol SettingsDependency: Dependency {
    var navigationController: UINavigationController { get }
}

public protocol SettingsBuilder {
    func makeSettingsSceneFlowCoordinator()-> SettingsSceneFlowCoordinator
    func makeSettingsViewController()-> UIViewController
}
