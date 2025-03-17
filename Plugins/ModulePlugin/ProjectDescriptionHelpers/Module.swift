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
        case login = "Login"
        case main = "Main"
        case home = "Home"
        case history = "History"
        case reminder = "Reminder"
        case settings = "Settings"
        
        case write = "Write"
    }
}

public extension Module {
    enum Domain: String {
        case home = "Home"
        case write = "Write"
    }
}

public extension Module {
    enum Core: String {
        case storage = "Storage"
    }
}

public extension Module {
    enum Shared: String {
        case ui = "UI"
        case utils = "Utils"
        case thirdPartyLibs = "ThirdPartyLibs"
    }
}
