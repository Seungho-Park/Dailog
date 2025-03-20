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

extension UIAppearance {
    static var fontUrls: [String: URL?] {
        return [
            "PatrickHand-Regular": Bundle.module.url(forResource: "PatrickHand-Regular", withExtension: "ttf"),
            "GildaDisplay-Regular": Bundle.module.url(forResource: "GildaDisplay-Regular", withExtension: "ttf"),
            "Gaegu-Regular": Bundle.module.url(forResource: "Gaegu-Regular", withExtension: "ttf"),
            "Gaegu-Light": Bundle.module.url(forResource: "Gaegu-Light", withExtension: "ttf"),
            "Gaegu-Bold": Bundle.module.url(forResource: "Gaegu-Bold", withExtension: "ttf"),
            
            // Korean -
            "Jalnan2": Bundle.module.url(forResource: "Jalnan2", withExtension: "otf"),
            "SejongGeulggot": Bundle.module.url(forResource: "SejongGeulggot", withExtension: "otf"),
            "온글잎 하루나눔": Bundle.module.url(forResource: "온글잎 하루나눔", withExtension: "ttf"),
            "온글잎 쑴체": Bundle.module.url(forResource: "온글잎 쑴체", withExtension: "ttf"),
            "온글잎 류뚱체": Bundle.module.url(forResource: "온글잎 류뚱체", withExtension: "ttf"),
            
            //Japanese -
            "mogihaPen": Bundle.module.url(forResource: "mogihaPen", withExtension: "ttf"),
            "natumemozi": Bundle.module.url(forResource: "natumemozi", withExtension: "ttf"),
            
            
            //Arabic
            "Lateef-Regular": Bundle.module.url(forResource: "Lateef-Regular", withExtension: "ttf"),
            "Lateef-Medium": Bundle.module.url(forResource: "Lateef-Medium", withExtension: "ttf"),
            "Lateef-Light": Bundle.module.url(forResource: "Lateef-Light", withExtension: "ttf"),
            "Lateef-ExtraLight": Bundle.module.url(forResource: "Lateef-ExtraLight", withExtension: "ttf"),
            "Lateef-ExtraBold": Bundle.module.url(forResource: "Lateef-ExtraBold", withExtension: "ttf"),
            "Lateef-Bold": Bundle.module.url(forResource: "Lateef-Bold", withExtension: "ttf"),
            "Lateef-SemiBold": Bundle.module.url(forResource: "Lateef-SemiBold", withExtension: "ttf"),
        ]
    }
}
