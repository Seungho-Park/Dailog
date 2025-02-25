//
//  MainScene.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureMainInterfaces
import SharedUIInterfaces

extension FeatureMainInterfaces.MainScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .main(let viewModel, let viewControllers):
            let vc = MainViewController.create(viewModel: viewModel as! DefaultMainViewModel)
            vc.viewControllers = viewControllers
            return vc
        }
    }
}
