//
//  SettingsScene.swift
//  FeatureSettings
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSettingsInterfaces
import SharedUIInterfaces

extension SettingsScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel):
            let vc = SettingsViewController.create(viewModel: viewModel as! DefaultSettingsViewModel)
            let tabBarItem = UITabBarItem()
            tabBarItem.title = "Settings".localized
            tabBarItem.image = UIImage(systemName: "gearshape")?.withTintColor(.tabBarItemColor, renderingMode: .alwaysOriginal)
            tabBarItem.image = UIImage(systemName: "gearshape")?.withTintColor(.tabBarItemSelectedsColor, renderingMode: .alwaysOriginal)
            vc.tabBarItem = tabBarItem
            return vc
        }
    }
}
