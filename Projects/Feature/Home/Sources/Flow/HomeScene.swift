//
//  HomeScene.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureHomeInterfaces

extension FeatureHomeInterfaces.HomeScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .home(let viewModel):
            let vc = HomeViewController.create(viewModel: viewModel as! DefaultHomeViewModel)
            vc.restorationIdentifier = "HomeViewController"
            let tabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(systemName: "house"), tag: 0)
            vc.tabBarItem = tabBarItem
            return vc
        }
    }
}
