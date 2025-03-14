//
//  Font+Extensions.swift
//  Manifests
//
//  Created by 박승호 on 2/20/25.
//

import SwiftUI

public extension UIFont {
    static func jalnan(_ size: CGFloat)-> UIFont {
        return UIFont(name: "Jalnan2", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func sejong(_ size: CGFloat)-> UIFont {
        return UIFont(name: "SejongGeulggot", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    static func ownglyph(_ size: CGFloat, _ weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .bold: return UIFont(name: "Ownglyph smartiam", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        case .medium: return UIFont(name: "Ownglyph konghae", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        case .regular: fallthrough
        default: return UIFont(name: "Ownglyph wiseelist", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
}
