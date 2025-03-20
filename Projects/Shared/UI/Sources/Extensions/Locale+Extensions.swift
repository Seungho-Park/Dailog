//
//  Locale+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces

public extension Locale {
    static var direction: TextDirection {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "ar":
            return .rightToLeft
        default: return .leftToRight
        }
    }
    
    static func getLocaleFromLangCode()-> Locale {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "ar": return Locale(identifier: "ar_SA")
        case "ja": return Locale(identifier: "ja_JP")
        case "en": return Locale(identifier: "en_US")
        case "ko": return Locale(identifier: "ko_KR")
        case "vi": return Locale(identifier: "vi_VN")
        case "th": return Locale(identifier: "th_TH")
        default: return Locale(identifier: "en_US")
        }
    }
    
    static var dateType: DateType {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "jp": return .yyyy_mm
        case "ko": return .yyyy_mm
        case "hi": fallthrough
        case "ar": fallthrough
        case "en":return .mm_yyyy
        default: return .mm_yyyy
        }
    }
}
