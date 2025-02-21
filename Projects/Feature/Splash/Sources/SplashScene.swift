//
//  SplashScene.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import UIKit
import FeatureSplashInterfaces
import SharedUIInterfaces

extension FeatureSplashInterfaces.SplashScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .splash(let viewModel):
            return SplashViewController<DefaultSplashViewModel>.create(viewModel: viewModel as! DefaultSplashViewModel)
        }
    }
}
