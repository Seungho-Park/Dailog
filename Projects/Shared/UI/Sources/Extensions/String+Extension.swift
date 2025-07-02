//
//  String+Extension.swift
//  SharedUI
//
//  Created by 박승호 on 7/2/25.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
