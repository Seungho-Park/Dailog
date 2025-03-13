//
//  HistoryScene.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureHistoryInterfaces

extension FeatureHistoryInterfaces.HistoryScene: SharedUIInterfaces.Scene {
    public func instantiate() -> UIViewController {
        switch self {
        case .history(let viewModel):
            let vc = HistoryViewController(nibName: nil, bundle: nil)
            vc.restorationIdentifier = "HistoryViewController"
            vc.view.backgroundColor = .clear
            vc.tabBarItem = .init(title: "History".localized, image: UIImage(systemName: "list.bullet.rectangle.portrait"), tag: 1)
            return vc
        }
    }
}
