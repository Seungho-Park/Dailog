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
            let vc = HistoryViewController<DefaultHistoryViewModel>.create(viewModel: viewModel as! DefaultHistoryViewModel)
            vc.restorationIdentifier = "HistoryViewController"
            vc.view.backgroundColor = .clear
            vc.tabBarItem = .init(title: "History".localized, image: UIImage(systemName: "list.bullet"), tag: 1)
            return vc
        case .filter(let viewModel):
            let vc = HistoryFilterViewController.create(viewModel: viewModel as! DefaultHistoryFilterViewModel)
            vc.modalPresentationStyle = .overFullScreen
            return vc
        }
    }
}
