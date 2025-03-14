//
//  UIFont+Extensions.swift
//  Manifests
//
//  Created by 박승호 on 2/20/25.
//

import SwiftUI

public extension UIFont {
    static func jalnan(_ size: CGFloat)-> UIFont {
        return UIFont(name: "Jalnan2", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func sejong(sizeOf size: CGFloat)-> UIFont {
        return UIFont(name: "SejongGeulggot", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    static func ownglyph(sizeOf size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .bold: return UIFont(name: "Ownglyph smartiam", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        case .medium: return UIFont(name: "Ownglyph konghae", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        case .regular: fallthrough
        default: return UIFont(name: "Ownglyph wiseelist", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    static func apple(sizeOf size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .black:
            return UIFont(name: "AppleSDGothicNeo-Black", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .bold:
            return UIFont(name: "AppleSDGothicNeo-Bold", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .light:
            return UIFont(name: "AppleSDGothicNeo-Light", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .medium:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .regular:
            return UIFont(name: "AppleSDGothicNeo-Regular", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .semibold:
            return UIFont(name: "AppleSDGothicNeo-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .thin:
            return UIFont(name: "AppleSDGothicNeo-Thin", size: size) ?? .systemFont(ofSize: size, weight: weight)
        case .ultraLight:
            return UIFont(name: "AppleSDGothicNeo-UltraLight", size: size) ?? .systemFont(ofSize: size, weight: weight)
        default:
            return .systemFont(ofSize: size, weight: weight)
        }
    }
}
