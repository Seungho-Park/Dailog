//
//  Module+Path.swift
//  ModuleDependencies
//
//  Created by 박승호 on 6/24/25.
//

import ProjectDescription

// MARK: - Application

public extension Path {
    static var application: Path {
        return .relativeToRoot("Projects/Application")
    }
}

// MARK: - Feature
public extension Path {
    static var feature: Path {
        return .relativeToRoot("Projects/Feature")
    }
    
    static func feature(implements module: Module.Feature)-> Path {
        return .relativeToRoot("Projects/Feature/\(module.rawValue)")
    }
}

// MARK: - Domain
public extension Path {
    static var domain: Path {
        return .relativeToRoot("Projects/Domain")
    }
    
    static func domain(implements module: Module.Domain)-> Path {
        return .relativeToRoot("Projects/Domain/\(module.rawValue)")
    }
}

// MARK: - Core
public extension Path {
    static var core: Path {
        return .relativeToRoot("Projects/Core")
    }
    
    static func core(implements module: Module.Core)-> Path {
        return .relativeToRoot("Projects/Core/\(module.rawValue)")
    }
}

// MARK: - Shared
public extension Path {
    static var shared: Path {
        return .relativeToRoot("Projects/Shared")
    }
    
    static func shared(implements module: Module.Shared)-> Path {
        return .relativeToRoot("Projects/Shared/\(module.rawValue)")
    }
}
