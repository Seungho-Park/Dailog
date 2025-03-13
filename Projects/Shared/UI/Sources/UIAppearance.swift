//
//  AppAppearance.swift
//  SharedUI
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText
import UIKit

public final class UIAppearance {
    private init() {  }
    
    public static func setup() {
        do {
            try loadFont()
            setupTabBar()
        } catch {
            print(error)
        }
    }
    
    private static func loadFont() throws {
        if let fontUrl = Bundle.module.url(forResource: "Jalnan2", withExtension: "otf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
                throw LoadError.font
            }
        } else {
            throw LoadError.font
        }
    }
    
    private static func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .tabBar
        appearance.shadowColor = nil
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor:UIColor.tabBarItemColor
        ]
        
        tabBarItemAppearance.normal.iconColor = UIColor.tabBarItemColor
        
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .bold),
            NSAttributedString.Key.foregroundColor:UIColor.tabBarItemSelectedsColor
        ]
        
        tabBarItemAppearance.selected.iconColor = UIColor.tabBarItemSelectedsColor
        
        appearance.stackedLayoutAppearance = tabBarItemAppearance
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
