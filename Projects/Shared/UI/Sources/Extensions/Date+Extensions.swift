//
//  Date+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public extension Date {
    func formattedString(format: String? = nil)-> String {
        let df = DateFormatter()
        df.dateFormat = format ?? getLanguageFormat()
        df.locale = Locale.getLocaleFromLangCode()
        return df.string(from: self)
    }
    
    private func getLanguageFormat()-> String {
        switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
        case "ko": return "yyyy/MM/dd (EEE)"
        case "ja": return "yyyy年MM月dd日 (EEE)"
        case "ar": return "dd/MM/yyyy, EEEE"
        case "en": return "EEE, MMM dd, yyyy"
        case "vi": return "dd/MM/yyyy (EEE)"
        case "th": return "dd/MM/yyyy (EEEE)"
        default: return "(EEE) MM/dd/yyyy"
        }
    }
    
    
}
