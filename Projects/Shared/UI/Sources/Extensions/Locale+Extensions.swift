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
}
