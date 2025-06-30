

import Feature
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

private class FeatureDependency1817fbd339445fa1fdd4Provider: FeatureDependency {


    init() {

    }
}
/// ^->AppComponent->FeatureComponent
private func factory9e7954469b0a05c0b761e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return FeatureDependency1817fbd339445fa1fdd4Provider()
}

#else
extension FeatureComponent: NeedleFoundation.Registration {
    public func registerItems() {

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
    registerProviderFactory("^->AppComponent->FeatureComponent", factory9e7954469b0a05c0b761e3b0c44298fc1c149afb)
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
