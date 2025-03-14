//
//  UILabel+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public extension UILabel {
    static func make(frame: CGRect)-> UILabel {
        let label = UILabel(frame: frame)
        
        switch Locale.direction {
        case .leftToRight:
            label.textAlignment = .left
            label.semanticContentAttribute = .forceLeftToRight
        case .rightToLeft:
            label.textAlignment = .right
            label.semanticContentAttribute = .forceRightToLeft
        }
        
        return label
    }
}
