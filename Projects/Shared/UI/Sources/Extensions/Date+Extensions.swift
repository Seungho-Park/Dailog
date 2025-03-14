//
//  Date+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public extension Date {
    func formattedString()-> String {
        let df = DateFormatter()
        df.dateFormat = getLanguageFormat()
        df.locale = getLocaleFromLangCode()
        return df.string(from: self)
    }
    
    private func getLanguageFormat()-> String {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "ko": return "yyyy/MM/dd (EEE)"
        case "ja": return "yyyy年MM月dd日 (EEE)"
        case "ar": return "dd/MM/yyyy, EEEE"
        case "en": return "(EEE) MM/dd/yyyy"
        case "vi": return "dd/MM/yyyy (EEE)"
        case "th": return "dd/MM/yyyy (EEEE)"
        default: return "(EEE) MM/dd/yyyy"
        }
    }
    
    private func getLocaleFromLangCode()-> Locale {
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
}
