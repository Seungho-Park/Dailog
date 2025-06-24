//
//  TargetDependency+Module.swift
//  ModuleDependencies
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription

// MARK: - Application

public extension TargetDependency {
    static let application: Self = .project(target: "Application", path: .application)
}

// MARK: - Feature

public extension TargetDependency {
    static let feature: Self = .project(target: "Feature", path: .feature)
    
    static func feature(interfaces module: Module.Feature)-> Self {
        return .project(target: "Feature\(module.rawValue)Interfaces", path: .feature(implements: module))
    }
    
    static func feature(implements module: Module.Feature)-> Self {
        return .project(target: "Feature\(module.rawValue)", path: .feature(implements: module))
    }
    
    static func feature(testing module: Module.Feature)-> Self {
        return .project(target: "Feature\(module.rawValue)Testing", path: .feature(implements: module))
    }
    
    static func feature(tests module: Module.Feature)-> Self {
        return .project(target: "Feature\(module.rawValue)Tests", path: .feature(implements: module))
    }
    
    static func feature(example module: Module.Feature)-> Self {
        return .project(target: "Feature\(module.rawValue)Example", path: .feature(implements: module))
    }
}

// MARK: - Domain

public extension TargetDependency {
    static let domain: Self = .project(target: "Domain", path: .domain)
    
    static func domain(interfaces module: Module.Domain)-> Self {
        return .project(target: "Domain\(module.rawValue)Interfaces", path: .domain(implements: module))
    }
    
    static func domain(implements module: Module.Domain)-> Self {
        return .project(target: "Domain\(module.rawValue)", path: .domain(implements: module))
    }
    
    static func domain(testing module: Module.Domain)-> Self {
        return .project(target: "Domain\(module.rawValue)Testing", path: .domain(implements: module))
    }
    
    static func domain(tests module: Module.Domain)-> Self {
        return .project(target: "Domain\(module.rawValue)Tests", path: .domain(implements: module))
    }
    
    static func domain(example module: Module.Domain)-> Self {
        return .project(target: "Domain\(module.rawValue)Example", path: .domain(implements: module))
    }
}

// MARK: - Core

public extension TargetDependency {
    static let core: Self = .project(target: "Core", path: .core)
    
    static func core(interfaces module: Module.Core)-> Self {
        return .project(target: "Core\(module.rawValue)Interfaces", path: .core(implements: module))
    }
    
    static func core(implements module: Module.Core)-> Self {
        return .project(target: "Core\(module.rawValue)", path: .core(implements: module))
    }
    
    static func core(testing module: Module.Core)-> Self {
        return .project(target: "Core\(module.rawValue)Testing", path: .core(implements: module))
    }
    
    static func core(tests module: Module.Core)-> Self {
        return .project(target: "Core\(module.rawValue)Tests", path: .core(implements: module))
    }
    
    static func core(example module: Module.Core)-> Self {
        return .project(target: "Core\(module.rawValue)Example", path: .core(implements: module))
    }
}

// MARK: - Shared

public extension TargetDependency {
    static let shared: Self = .project(target: "Shared", path: .shared)
    
    static func shared(interfaces module: Module.Shared)-> Self {
        return .project(target: "Shared\(module.rawValue)Interfaces", path: .shared(implements: module))
    }
    
    static func shared(implements module: Module.Shared)-> Self {
        return .project(target: "Shared\(module.rawValue)", path: .shared(implements: module))
    }
    
    static func shared(testing module: Module.Shared)-> Self {
        return .project(target: "Shared\(module.rawValue)Testing", path: .shared(implements: module))
    }
    
    static func shared(tests module: Module.Shared)-> Self {
        return .project(target: "Shared\(module.rawValue)Tests", path: .shared(implements: module))
    }
    
    static func shared(example module: Module.Shared)-> Self {
        return .project(target: "Shared\(module.rawValue)Example", path: .shared(implements: module))
    }
}
