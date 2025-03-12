//
//  Target+Template.swift
//  Manifests
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription
import ModulePlugin

public extension ProjectDescription.Target {
    struct TargetFactory {
        var name: String
        var destinations: ProjectDescription.Destinations
        var product: ProjectDescription.Product
        var productName: String?
        var bundleId: String?
        var deploymentTargets: ProjectDescription.DeploymentTargets?
        var infoPlist: ProjectDescription.InfoPlist?
        var sources: ProjectDescription.SourceFilesList?
        var resources: ProjectDescription.ResourceFileElements?
        var copyFiles: [ProjectDescription.CopyFilesAction]?
        var headers: ProjectDescription.Headers?
        var entitlements: ProjectDescription.Entitlements?
        var scripts: [ProjectDescription.TargetScript]
        var dependencies: [ProjectDescription.TargetDependency]
        var settings: ProjectDescription.Settings?
        var coreDataModels: [ProjectDescription.CoreDataModel]
        var environmentVariables: [String : ProjectDescription.EnvironmentVariable]
        var launchArguments: [ProjectDescription.LaunchArgument]
        var additionalFiles: [ProjectDescription.FileElement]
        var buildRules: [ProjectDescription.BuildRule]
        var mergedBinaryType: ProjectDescription.MergedBinaryType
        var mergeable: Bool
        var onDemandResourcesTags: ProjectDescription.OnDemandResourcesTags?
        
        public init(
            name: String = "",
            destinations: ProjectDescription.Destinations = .iOS,
            product: ProjectDescription.Product = Environment.forPreview.getBoolean(default: false) ? .framework : .staticFramework,
            productName: String? = nil,
            bundleId: String? = nil,
            deploymentTargets: ProjectDescription.DeploymentTargets? = Project.Environment.deploymentTarget,
            infoPlist: ProjectDescription.InfoPlist? = .extendingDefault(with: [:]),
            sources: ProjectDescription.SourceFilesList? = .sources,
            resources: ProjectDescription.ResourceFileElements? = nil,
            copyFiles: [ProjectDescription.CopyFilesAction]? = nil,
            headers: ProjectDescription.Headers? = nil,
            entitlements: ProjectDescription.Entitlements? = nil,
            scripts: [ProjectDescription.TargetScript] = [],
            dependencies: [ProjectDescription.TargetDependency],
            settings: ProjectDescription.Settings? = .settings(base: [
                "DEFINES_MODULE": false,
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC"
                ],
                "ENABLE_USER_SCRIPT_SANDBOXING": true,
                "GENERATE_ASSET_SYMBOL_EXTENSIONS": true
            ]),
            coreDataModels: [ProjectDescription.CoreDataModel] = [],
            environmentVariables: [String : ProjectDescription.EnvironmentVariable] = [:],
            launchArguments: [ProjectDescription.LaunchArgument] = [],
            additionalFiles: [ProjectDescription.FileElement] = [],
            buildRules: [ProjectDescription.BuildRule] = [],
            mergedBinaryType: ProjectDescription.MergedBinaryType = .disabled,
            mergeable: Bool = false,
            onDemandResourcesTags: ProjectDescription.OnDemandResourcesTags? = nil
        ) {
            self.name = name
            self.destinations = destinations
            self.product = product
            self.productName = productName
            self.bundleId = bundleId
            self.deploymentTargets = deploymentTargets
            self.infoPlist = infoPlist
            self.sources = sources
            self.resources = resources
            self.copyFiles = copyFiles
            self.headers = headers
            self.entitlements = entitlements
            self.scripts = scripts
            self.dependencies = dependencies
            self.settings = settings
            self.coreDataModels = coreDataModels
            self.environmentVariables = environmentVariables
            self.launchArguments = launchArguments
            self.additionalFiles = additionalFiles
            self.buildRules = buildRules
            self.mergedBinaryType = mergedBinaryType
            self.mergeable = mergeable
            self.onDemandResourcesTags = onDemandResourcesTags
        }
        
        func toTarget()-> ProjectDescription.Target {
            return .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId ?? Project.Environment.bundleId + ".\(name)",
                deploymentTargets: deploymentTargets,
                infoPlist: infoPlist,
                sources: sources,
                resources: resources,
                copyFiles: copyFiles,
                headers: headers,
                entitlements: entitlements,
                scripts: scripts,
                dependencies: dependencies,
                settings: settings,
                coreDataModels: coreDataModels,
                environmentVariables: environmentVariables,
                launchArguments: launchArguments,
                additionalFiles: additionalFiles,
                buildRules: buildRules,
                mergedBinaryType: mergedBinaryType,
                mergeable: mergeable,
                onDemandResourcesTags: onDemandResourcesTags
            )
        }
    }
}

public extension ProjectDescription.Target {
    static func application(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = Project.Environment.appName
        factory.product = .app
        factory.bundleId = Project.Environment.bundleId
        factory.productName = Project.Environment.appName
        return factory.toTarget()
    }
}

public extension ProjectDescription.Target {
    static func feature(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature"
        return factory.toTarget()
    }
    
    static func feature(interfaces module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Interfaces"
        factory.sources = .interfaces
        return factory.toTarget()
    }
    
    static func feature(implements module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)"
        return factory.toTarget()
    }
    
    static func feature(testing module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Testing"
        factory.sources = .testing
        return factory.toTarget()
    }
    
    static func feature(tests module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        return factory.toTarget()
    }
    
    static func feature(example module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Example"
        factory.product = .app
        factory.sources = .example
        factory.infoPlist = .example
        return factory.toTarget()
    }
}

public extension ProjectDescription.Target {
    static func domain(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain"
        return factory.toTarget()
    }
}

public extension ProjectDescription.Target {
    static func core(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core"
        return factory.toTarget()
    }
    
    static func core(interfaces module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Interfaces"
        factory.sources = .interfaces
        return factory.toTarget()
    }
    
    static func core(implements module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)"
        return factory.toTarget()
    }
    
    static func core(testing module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Testing"
        factory.sources = .testing
        return factory.toTarget()
    }
    
    static func core(tests module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        return factory.toTarget()
    }
    
    static func core(example module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Example"
        factory.product = .app
        factory.sources = .example
        factory.infoPlist = .example
        return factory.toTarget()
    }
}

public extension ProjectDescription.Target {
    static func shared(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Shared"
        return factory.toTarget()
    }
    
    static func shared(implements module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)"
        return factory.toTarget()
    }
    
    static func shared(interfaces module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Interfaces"
        factory.sources = .interfaces
        return factory.toTarget()
    }
    
    static func shared(testing module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Testing"
        factory.sources = .testing
        return factory.toTarget()
    }
    
    static func shared(tests module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Tests"
        factory.sources = .tests
        return factory.toTarget()
    }
    
    static func shared(example module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Example"
        factory.sources = .example
        factory.product = .app
        factory.infoPlist = .example
        return factory.toTarget()
    }
}
