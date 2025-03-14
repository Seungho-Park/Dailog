//
//  String+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
    
    var prompt: String {
        NSLocalizedString(self, tableName: "Prompt", bundle: .module, comment: "")
    }
}
