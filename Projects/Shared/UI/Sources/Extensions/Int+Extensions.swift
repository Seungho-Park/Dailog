//
//  Int+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 3/21/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation

public extension Int {
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale.getLocaleFromLangCode()
        return df
    }()
    
    var monthString: String {
        guard self > 0, self <= 12 else { return "\(self)" }
        Int.dateFormatter.dateFormat = "MM"
        
        let date = Int.dateFormatter.date(from: String(format: "%02d", self))!
        Int.dateFormatter.setLocalizedDateFormatFromTemplate("MMM")
        return Int.dateFormatter.string(from: date)
    }
    
    var yearString: String {
        guard self > 1000, self <= 9999 else { return "\(self)" }
        Int.dateFormatter.dateFormat = "yyyy"
        
        let date = Int.dateFormatter.date(from: String(format: "%04d", self))!
        Int.dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
        return Int.dateFormatter.string(from: date)
    }
}
