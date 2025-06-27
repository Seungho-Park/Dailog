//
//  Module.swift
//  ModuleDependencies
//
//  Created by 박승호 on 6/24/25.
//

public enum Module {
    case feature
    case domain
    case core
    case shared
}

public extension Module {
    enum Feature: String {
        case home = "Home"
        
        public static let name: String = "Feature"
    }
}

public extension Module {
    enum Domain: String {
        case application = "Application"
        
        public static let name: String = "Domain"
    }
}

public extension Module {
    enum Core: String {
        case storage = "Storage"
        
        public static let name: String = "Core"
    }
}

public extension Module {
    enum Shared: String {
        case ui = "UI"
        case app = "App"
        
        public static let name: String = "Shared"
    }
}
