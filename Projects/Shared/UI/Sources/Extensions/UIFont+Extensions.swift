//
//  UIFont+Extensions.swift
//  Manifests
//
//  Created by 박승호 on 2/20/25.
//

import SwiftUI

public extension UIFont {
    var italic: UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(.traitItalic) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func applyingWeight(_ weight: UIFont.Weight) -> UIFont {
        let newDescriptor = fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: newDescriptor, size: 0)
    }
    
    static func jalnan(_ size: CGFloat)-> UIFont {
        return UIFont(name: "Jalnan2", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
    
    static func sejong(sizeOf size: CGFloat)-> UIFont {
        return UIFont(name: "SejongGeulggot", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    }
    
    static func serif(sizeOf size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "en": return UIFont(name: "Georgia", size: size)!.applyingWeight(.bold)
        default: return UIFont(name: "Georgia", size: size)!.applyingWeight(weight)
        }
    }
    
    static func cursive(sizeOf size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "ja":
            switch weight {
            case .regular: return UIFont(name: "MogihaPenFont", size: size)!
            default: return UIFont(name: "Natsume", size: size)!
            }
        case "en": return cursiveEnglish(size, weight: weight)
        case "ko": return cursiveKorean(size, weight: weight)
        case "ar": return cursiveArabic(size, weight: weight)
        default: return UIFont.systemFont(ofSize: size, weight: weight)
        }
    }
    
    private static func cursiveEnglish(_ size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .light: fallthrough
        case .regular: return UIFont(name: "Gaegu-Light", size: size)!
        case .medium: return UIFont(name: "Gaegu-Regular", size: size)!
        case .bold: return UIFont(name: "Gaegu-Bold", size: size)!
        default: return UIFont(name: "Gaegu-Regular", size: size)!
        }
    }
    
    private static func cursiveKorean(_ size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .bold: return UIFont(name: "Ownglyph soomini", size: size) ?? .systemFont(ofSize: size, weight: .bold)
        case .medium: return UIFont(name: "Ownglyph ryuttung", size: size) ?? .systemFont(ofSize: size, weight: .medium)
        case .regular: fallthrough
        default: return UIFont(name: "Ownglyph haru nanum", size: size) ?? .systemFont(ofSize: size, weight: .regular)
        }
    }
    
    private static func cursiveArabic(_ size: CGFloat, weight: UIFont.Weight)-> UIFont {
        switch weight {
        case .thin: fallthrough
        case .regular: return UIFont(name: "Lateef-Regular", size: size)!
        case .medium: return UIFont(name: "Lateef-Medium", size: size)!
        case .light: return UIFont(name: "Lateef-Light", size: size)!
        case .ultraLight: return UIFont(name: "Lateef-ExtraLight", size: size)!
        case .bold: return UIFont(name: "Lateef-Bold", size: size)!
        case .semibold: return UIFont(name: "Lateef-SemiBold", size: size)!
        case .black: fallthrough
        case .heavy: return UIFont(name: "Lateef-ExtraBold", size: size)!
        default: return UIFont(name: "Lateef-Regular", size: size)!
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
