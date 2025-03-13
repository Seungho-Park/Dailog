//
//  ReminderScene.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import SharedUIInterfaces
import FeatureReminderInterfaces

extension FeatureReminderInterfaces.ReminderScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .reminder(let vm):
            let vc = UIViewController(nibName: nil, bundle: nil)
            vc.tabBarItem = UITabBarItem(title: "Reminder".localized, image: UIImage(systemName: "text.page.badge.magnifyingglass"), tag: 2)
            return vc
        }
    }
}
