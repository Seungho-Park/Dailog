import UIKit
import NeedleFoundation

public final class SettingsComponent: Component<SettingsDependency>, SettingsBuilder {
    public func makeSettingsSceneFlowCoordinator() -> any SettingsSceneFlowCoordinator {
        return DefaultSettingsSceneFlowCoordinator(navigationController: dependency.navigationController, builder: self)
    }
    
    public func makeSettingsViewController() -> UIViewController {
        let vc = UIViewController()
        vc.tabBarItem = .init(title: "Settings".localized, image: nil, tag: 3)
        return vc
    }
}
