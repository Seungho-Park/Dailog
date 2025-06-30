//
//  UIColor+Extension.swift
//  SharedUI
//
//  Created by 박승호 on 6/30/25.
//

import UIKit

public extension UIColor {
    
    static func component(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1)-> UIColor {
        return .init(
            red: r <= 1 ? r : r / 255,
            green: g <= 1 ? g : g / 255,
            blue: b <= 1 ? b : b / 255,
            alpha: a <= 1 ? a : a / 255
        )
    }
}
