//
//  TargetDependency.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//
import ProjectDescription

public extension ProjectDescription.TargetDependency {
    static var application: TargetDependency {
        return .project(target: "Application", path: .application, status: .required)
    }
}

public extension ProjectDescription.TargetDependency {
    static var feature: TargetDependency {
        return .project(target: "Feature", path: .feature, status: .required)
    }
    
    static func feature(interfaces module: Module.Feature)-> TargetDependency {
        return .project(target: "Feature\(module.rawValue)Interfaces", path: .feature(module), status: .required)
    }
    
    static func feature(implements module: Module.Feature)-> TargetDependency {
        return .project(target: "Feature\(module.rawValue)", path: .feature(module), status: .required)
    }
    
    static func feature(testing module: Module.Feature)-> TargetDependency {
        return .project(target: "Feature\(module.rawValue)Testing", path: .feature(module), status: .required)
    }
    
    static func feature(tests module: Module.Feature)-> TargetDependency {
        return .project(target: "Feature\(module.rawValue)Tests", path: .feature(module), status: .required)
    }
    
    static func feature(example module: Module.Feature)-> TargetDependency {
        return .project(target: "Feature\(module.rawValue)Example", path: .feature(module), status: .required)
    }
}

public extension ProjectDescription.TargetDependency {
    static var domain: TargetDependency {
        return .project(target: "Domain", path: .domain, status: .required)
    }
    
    static func domain(implements module: Module.Domain)-> TargetDependency {
        return .project(target: "Domain\(module)", path: .domain(module), status: .required)
    }
}

public extension ProjectDescription.TargetDependency {
    static var core: TargetDependency {
        return .project(target: "Core", path: .core, status: .required)
    }
    
    static func core(interfaces module: Module.Core)-> TargetDependency {
        return .project(target: "Core\(module.rawValue)Interfaces", path: .core(module), status: .required)
    }
    
    static func core(implements module: Module.Core)-> TargetDependency {
        return .project(target: "Core\(module.rawValue)", path: .core(module), status: .required)
    }
    
    static func core(testing module: Module.Core)-> TargetDependency {
        return .project(target: "Core\(module.rawValue)Testing", path: .core(module), status: .required)
    }
    
    static func core(tests module: Module.Core)-> TargetDependency {
        return .project(target: "Core\(module.rawValue)Tests", path: .core(module), status: .required)
    }
    
    static func core(example module: Module.Core)-> TargetDependency {
        return .project(target: "Core\(module.rawValue)Example", path: .core(module), status: .required)
    }
}

public extension ProjectDescription.TargetDependency {
    static var shared: TargetDependency {
        return .project(target: "Shared", path: .shared, status: .required)
    }
    
    static func shared(implements module: Module.Shared)-> TargetDependency {
        return .project(target: "Shared\(module.rawValue)", path: .shared(module), status: .required)
    }
    
    static func shared(interfaces module: Module.Shared)-> TargetDependency {
        return .project(target: "Shared\(module.rawValue)Interfaces", path: .shared(module), status: .required)
    }
}

