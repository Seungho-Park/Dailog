//
//  UIColor+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public extension UIColor {
    static func component(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1)-> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha)
    }
    
    static let tabBar: UIColor = UIColor(resource: .init(name: "Tabbar", bundle: .module))
    static let icon: UIColor = UIColor(resource: .init(name: "IconColor", bundle: .module))
    static let tabBarItemColor: UIColor = UIColor(resource: .init(name: "TabBarItemColor", bundle: .module))
    static let tabBarItemSelectedsColor: UIColor = UIColor(resource: .init(name: "TabBarItemSelectedColor", bundle: .module))
}
