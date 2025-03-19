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
    
    var image: UIImage {
        let rect = CGRect(origin: .zero, size: .init(width: 1, height: 1))
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { context in
            self.setFill()
            context.fill(rect)
        }
    }
    
    static let navigationTitle = UIColor(resource: .init(name: "NavigationTitle", bundle: .module))
    static let title: UIColor = UIColor(resource: .init(name: "TitleColor", bundle: .module))
    
    static let bgButton: UIColor = UIColor(resource: .init(name: "SoftCoral", bundle: .module))
    static let btnTextColor: UIColor = UIColor(resource: .init(name: "ButtonText", bundle: .module))
    
    static let softCoral: UIColor = UIColor(resource: .init(name: "SoftCoral", bundle: .module))
    static let softCoralHighlight: UIColor = UIColor(resource: .init(name: "SoftCoralHighlight", bundle: .module))
    static let deepGray: UIColor = UIColor(resource: .init(name: "DarkGray", bundle: .module))
    static let cream: UIColor = UIColor(resource: .init(name: "Cream", bundle: .module))
    
    static let separatorColor: UIColor = UIColor(resource: .init(name: "Separator", bundle: .module))
    static let textColor: UIColor = UIColor(resource: .init(name: "TextColor", bundle: .module))
    
    static let tabBar: UIColor = UIColor(resource: .init(name: "Tabbar", bundle: .module))
    static let icon: UIColor = UIColor(resource: .init(name: "IconColor", bundle: .module))
    static let tabBarItemColor: UIColor = UIColor(resource: .init(name: "TabBarItemColor", bundle: .module))
    static let tabBarItemSelectedsColor: UIColor = UIColor(resource: .init(name: "TabBarItemSelectedColor", bundle: .module))
}
