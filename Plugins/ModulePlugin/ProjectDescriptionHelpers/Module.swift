//
//  ModulePath.swift
//  ModulePlugin
//
//  Created by 박승호 on 2/19/25.
//

import ProjectDescription

public enum Module {
    case feature(Feature)
    case domain(Domain)
    case core(Core)
    case shared(Shared)
}

public extension Module {
    enum Feature: String {
        case splash = "Splash"
    }
}

public extension Module {
    enum Domain {
        
    }
}

public extension Module {
    enum Core {
        
    }
}

public extension Module {
    enum Shared: String {
        case ui = "UI"
        case utils = "Utils"
    }
}
