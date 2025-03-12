//
//  Module+Path.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public extension ProjectDescription.Path {
    static var application: Self {
        return .relativeToRoot("Projects/Application")
    }
}


public extension ProjectDescription.Path {
    static var feature: Self {
        return .relativeToRoot("Projects/Feature")
    }
    
    static func feature(_ module: Module.Feature)-> Self {
        return .relativeToRoot("Projects/Feature/\(module.rawValue)")
    }
}

public extension ProjectDescription.Path {
    static var core: Self {
        return .relativeToRoot("Projects/Core")
    }
    
    static func core(_ module: Module.Core)-> Self {
        return .relativeToRoot("Projects/Core/\(module.rawValue)")
    }
}

public extension ProjectDescription.Path {
    static var domain: Self {
        return .relativeToRoot("Projects/Domain")
    }
    
    static func domain(_ module: Module.Domain)-> Self {
        return .relativeToRoot("Projects/Domain/\(module)")
    }
}

public extension ProjectDescription.Path {
    static var shared: Self {
        return .relativeToRoot("Projects/Shared")
    }
    
    static func shared(_ module: Module.Shared)-> Path {
        return .relativeToRoot("Projects/Shared/\(module.rawValue)")
    }
}
