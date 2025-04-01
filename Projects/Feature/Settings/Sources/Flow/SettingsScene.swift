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
        case .settings(let viewModel):
            let vc = SettingsViewController.create(viewModel: viewModel as! DefaultSettingsViewModel)
            vc.tabBarItem = UITabBarItem(title: "Settings".localized, image: UIImage(systemName: "gearshape"), tag: 3)
            return vc
        }
    }
}
