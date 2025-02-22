//
//  MainViewController.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureSplashInterfaces
import FeatureMainInterfaces
import SharedUI

public final class MainViewController<VM: MainViewModel>: DailogViewController<VM> {
    private lazy var tabController: UITabBarController = {
        let tabBar = UITabBarController()
        return tabBar
    }()
    
    public override func configure() {
        super.configure()
        self.addChild(tabController)
        self.view.addSubview(tabController.view)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabController.view.pin.all(self.view.pin.safeArea)
    }
}
