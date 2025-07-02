

import Feature
import FeatureHistory
import FeatureHome
import NeedleFoundation
import Shared
import SharedApp
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class HomeDependencye3ac70f14506542acd23Provider: HomeDependency {
    var navigationController: UINavigationController {
        return featureComponent.navigationController
    }
    private let featureComponent: FeatureComponent
    init(featureComponent: FeatureComponent) {
        self.featureComponent = featureComponent
    }
}
/// ^->AppComponent->FeatureComponent->HomeComponent
private func factory6128bf102011e8ea2ddd88746407249bf4c57657(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeDependencye3ac70f14506542acd23Provider(featureComponent: parent1(component) as! FeatureComponent)
}
private class HistoryDependency2782f1d4044826822703Provider: HistoryDependency {
    var navigationController: UINavigationController {
        return featureComponent.navigationController
    }
    private let featureComponent: FeatureComponent
    init(featureComponent: FeatureComponent) {
        self.featureComponent = featureComponent
    }
}
/// ^->AppComponent->FeatureComponent->HistoryComponent
private func factory203a3d41758e2594589f88746407249bf4c57657(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HistoryDependency2782f1d4044826822703Provider(featureComponent: parent1(component) as! FeatureComponent)
}
private class FeatureDependency1817fbd339445fa1fdd4Provider: FeatureDependency {


    init() {

    }
}
/// ^->AppComponent->FeatureComponent
private func factory9e7954469b0a05c0b761e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FeatureDependency1817fbd339445fa1fdd4Provider()
}

#else
extension HomeComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.navigationController] = "navigationController-UINavigationController"
    }
}
extension HistoryComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\HistoryDependency.navigationController] = "navigationController-UINavigationController"
    }
}
extension FeatureComponent: NeedleFoundation.Registration {
    public func registerItems() {

        localTable["navigationController-UINavigationController"] = { [unowned self] in self.navigationController as Any }
        localTable["coordinator-FeatureFlowCoordinator"] = { [unowned self] in self.coordinator as Any }
        localTable["homeBuilder-HomeBuilder"] = { [unowned self] in self.homeBuilder as Any }
        localTable["historyBuilder-HistoryBuilder"] = { [unowned self] in self.historyBuilder as Any }
    }
}
extension AppComponent: NeedleFoundation.Registration {
    public func registerItems() {

        localTable["featureComponent-FeatureBuilder"] = { [unowned self] in self.featureComponent as Any }
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->AppComponent->FeatureComponent->HomeComponent", factory6128bf102011e8ea2ddd88746407249bf4c57657)
    registerProviderFactory("^->AppComponent->FeatureComponent->HistoryComponent", factory203a3d41758e2594589f88746407249bf4c57657)
    registerProviderFactory("^->AppComponent->FeatureComponent", factory9e7954469b0a05c0b761e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
