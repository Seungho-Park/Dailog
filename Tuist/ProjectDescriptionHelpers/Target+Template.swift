//
//  Target+Template.swift
//  Manifests
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription
import ModuleDependencies

// MARK: - Factory
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
        var EnvironmentVariables: [String : ProjectDescription.EnvironmentVariable]
        var launchArguments: [ProjectDescription.LaunchArgument]
        var additionalFiles: [ProjectDescription.FileElement]
        var buildRules: [ProjectDescription.BuildRule]
        var mergedBinaryType: ProjectDescription.MergedBinaryType
        var mergeable: Bool
        var onDemandResourcesTags: ProjectDescription.OnDemandResourcesTags?
        
        public init(
            name: String = "",
            destinations: ProjectDescription.Destinations = .iOS,
            product: ProjectDescription.Product = .staticFramework,
            productName: String? = nil,
            bundleId: String? = nil,
            deploymentTargets: ProjectDescription.DeploymentTargets? = Project.Environments.deploymentTarget,
            infoPlist: ProjectDescription.InfoPlist? = .extendingDefault(with: [:]),
            sources: ProjectDescription.SourceFilesList? = .sources,
            resources: ProjectDescription.ResourceFileElements? = nil,
            copyFiles: [ProjectDescription.CopyFilesAction]? = nil,
            headers: ProjectDescription.Headers? = nil,
            entitlements: ProjectDescription.Entitlements? = nil,
            scripts: [ProjectDescription.TargetScript] = [],
            dependencies: [ProjectDescription.TargetDependency],
            settings: ProjectDescription.Settings? = .settings(base: [
                "OTHER_LDFLAGS": [
                    "$(inherited) -ObjC"
                ],
                "DEFINES_MODULE": "NO",
                "DEBUG_INFORMATION_FORMAT":"dwarf-with-dsym"
            ]),
            coreDataModels: [ProjectDescription.CoreDataModel] = [],
            EnvironmentVariables: [String : ProjectDescription.EnvironmentVariable] = [:],
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
            self.EnvironmentVariables = EnvironmentVariables
            self.launchArguments = launchArguments
            self.additionalFiles = additionalFiles
            self.buildRules = buildRules
            self.mergedBinaryType = mergedBinaryType
            self.mergeable = mergeable
            self.onDemandResourcesTags = onDemandResourcesTags
        }
        
        func build()-> ProjectDescription.Target {
            return .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: bundleId ?? Project.Environments.bundleIdentifier + ".\(name.lowercased())",
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
                environmentVariables: EnvironmentVariables,
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


// MARK: - Application

public extension ProjectDescription.Target {
    static func application(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = Project.Environments.appName
        factory.product = .app
        factory.bundleId = Project.Environments.bundleIdentifier
        factory.productName = Project.Environments.appName
        factory.deploymentTargets = Project.Environments.deploymentTarget
        factory.destinations = [.iPhone, .macWithiPadDesign]
        return factory.build()
    }
}

// MARK: - Feature

public extension ProjectDescription.Target {
    static func feature(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature"
        return factory.build()
    }
    
    static func feature(interface module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Interfaces"
        factory.sources = .interfaces
        factory.bundleId = Project.Environments.bundleIdentifier + ".feature.\(module.rawValue.lowercased()).interfaces"
        return factory.build()
    }
    
    static func feature(implements module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)"
        factory.bundleId = Project.Environments.bundleIdentifier + ".feature.\(module.rawValue.lowercased())"
        return factory.build()
    }
    
    static func feature(testing module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Testing"
        factory.sources = .testing
        factory.bundleId = Project.Environments.bundleIdentifier + ".feature.\(module.rawValue.lowercased()).testing"
        return factory.build()
    }
    
    static func feature(tests module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        factory.bundleId = Project.Environments.bundleIdentifier + ".feature.\(module.rawValue.lowercased()).tests"
        return factory.build()
    }
    
    static func feature(example module: Module.Feature, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Feature\(module.rawValue)Example"
        factory.product = .app
        factory.sources = .example
//        factory.infoPlist = .example
        factory.bundleId = Project.Environments.bundleIdentifier + ".feature.\(module.rawValue.lowercased()).example"
        return factory.build()
    }
}

public extension ProjectDescription.Target {
    static func domain(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain"
        return factory.build()
    }
    
    static func domain(interface module: Module.Domain, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain\(module.rawValue)Interfaces"
        factory.bundleId = Project.Environments.bundleIdentifier + ".domain.\(module.rawValue.lowercased()).interfaces"
        factory.sources = .interfaces
        return factory.build()
    }
    
    static func domain(implements module: Module.Domain, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain\(module.rawValue)"
        factory.bundleId = Project.Environments.bundleIdentifier + ".domain.\(module.rawValue.lowercased())"
        return factory.build()
    }
    
    static func domain(testing module: Module.Domain, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain\(module.rawValue)Testing"
        factory.bundleId = Project.Environments.bundleIdentifier + ".domain.\(module.rawValue.lowercased()).testing"
        factory.sources = .testing
        return factory.build()
    }
    
    static func domain(tests module: Module.Domain, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        factory.bundleId = Project.Environments.bundleIdentifier + ".domain.\(module.rawValue.lowercased()).tests"
        return factory.build()
    }
    
    static func domain(example module: Module.Domain, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Domain\(module.rawValue)Example"
        factory.product = .app
        factory.sources = .example
//        factory.infoPlist = .example
        factory.bundleId = Project.Environments.bundleIdentifier + ".domain.\(module.rawValue.lowercased()).example"
        return factory.build()
    }
}

public extension ProjectDescription.Target {
    static func core(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core"
        return factory.build()
    }
    
    static func core(interface module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Interfaces"
        factory.bundleId = Project.Environments.bundleIdentifier + ".core.\(module.rawValue.lowercased()).interfaces"
        factory.sources = .interfaces
        return factory.build()
    }
    
    static func core(implements module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)"
        factory.bundleId = Project.Environments.bundleIdentifier + ".core.\(module.rawValue.lowercased())"
        return factory.build()
    }
    
    static func core(testing module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Testing"
        factory.sources = .testing
        factory.bundleId = Project.Environments.bundleIdentifier + ".core.\(module.rawValue.lowercased()).testing"
        return factory.build()
    }
    
    static func core(tests module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        factory.bundleId = Project.Environments.bundleIdentifier + ".core.\(module.rawValue.lowercased()).tests"
        return factory.build()
    }
    
    static func core(example module: Module.Core, factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Core\(module.rawValue)Example"
        factory.product = .app
        factory.sources = .example
//        factory.infoPlist = .example
        factory.bundleId = Project.Environments.bundleIdentifier + ".core.\(module.rawValue.lowercased()).example"
        return factory.build()
    }
}

public extension ProjectDescription.Target {
    static func shared(_ factory: TargetFactory)-> Self {
        var factory = factory
        factory.name = "Shared"
        return factory.build()
    }
    
    static func shared(implements module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)"
        factory.bundleId = Project.Environments.bundleIdentifier + ".shared.\(module.rawValue.lowercased())"
        return factory.build()
    }
    
    static func shared(interface module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Interfaces"
        factory.sources = .interfaces
        factory.bundleId = Project.Environments.bundleIdentifier + ".shared.\(module.rawValue.lowercased()).interfaces"
        return factory.build()
    }
    
    static func shared(testing module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Testing"
        factory.sources = .testing
        factory.bundleId = Project.Environments.bundleIdentifier + ".shared.\(module.rawValue.lowercased()).testing"
        return factory.build()
    }
    
    static func shared(tests module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Tests"
        factory.product = .unitTests
        factory.sources = .tests
        factory.bundleId = Project.Environments.bundleIdentifier + ".shared.\(module.rawValue.lowercased()).tests"
        return factory.build()
    }
    
    static func shared(example module: Module.Shared, factory: TargetFactory)-> Target {
        var factory = factory
        factory.name = "Shared\(module.rawValue)Example"
        factory.sources = .example
        factory.product = .app
//        factory.infoPlist = .example
        factory.bundleId = Project.Environments.bundleIdentifier + ".shared.\(module.rawValue.lowercased()).example"
        return factory.build()
    }
}
