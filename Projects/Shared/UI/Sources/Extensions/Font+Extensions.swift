//
//  Font+Extensions.swift
//  Manifests
//
//  Created by 박승호 on 2/20/25.
//

import SwiftUI

public extension UIFont {
    static func jalnan(_ size: CGFloat)-> UIFont {
        return UIFont(name: "Jalnan2", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
}
