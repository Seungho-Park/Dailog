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
        loadFont()
        setupTabBar()
    }
    
    private static func loadFont() {
        let fontUrls: [String:URL?] = [
            "Jalnan2": Bundle.module.url(forResource: "Jalnan2", withExtension: "otf"),
            "SejongGeulggot": Bundle.module.url(forResource: "SejongGeulggot", withExtension: "otf"),
            "Ownglyph wiseelist": Bundle.module.url(forResource: "Ownglyph wiseelist", withExtension: "ttf"),
            "Ownglyph smartiam": Bundle.module.url(forResource: "Ownglyph smartiam", withExtension: "ttf"),
            "Ownglyph konghae": Bundle.module.url(forResource: "Ownglyph konghae", withExtension: "ttf")
        ]
        
        for (key, url) in fontUrls {
            guard let url = url, CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
            else {
                print("Load font failed: \(key)")
                continue
            }
        }
        
        for font in UIFont.familyNames {
            print(font)
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
