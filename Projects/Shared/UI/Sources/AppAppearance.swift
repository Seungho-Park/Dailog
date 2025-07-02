//
//  AppAppearance.swift
//  SharedUI
//
//  Created by 박승호 on 7/2/25.
//

import UIKit

public final class AppAppearance {
    private init() {  }
    
    public static func configure() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.tabBarBackground
        appearance.shadowColor = nil
        
        
        let tabBarItemAppearance = UITabBarItemAppearance()
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .medium),
            NSAttributedString.Key.foregroundColor:UIColor.tabBarItem
        ]
        
        tabBarItemAppearance.normal.iconColor = UIColor.tabBarItem
        
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12, weight: .bold),
            NSAttributedString.Key.foregroundColor:UIColor.tabBarItemSelected
        ]
        
        tabBarItemAppearance.selected.iconColor = UIColor.tabBarItemSelected
        
        appearance.stackedLayoutAppearance = tabBarItemAppearance
                
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
