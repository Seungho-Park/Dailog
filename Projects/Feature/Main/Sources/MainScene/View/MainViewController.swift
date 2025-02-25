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
        tabBar.view.backgroundColor = .clear
        return tabBar
    }()
    
    public var viewControllers: [UIViewController] {
        get { tabController.viewControllers ?? [] }
        set { tabController.viewControllers = newValue }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        super.configure()
        self.addChild(tabController)
        self.container.addSubview(tabController.view)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabController.view.pin.top(self.container.pin.safeArea.top).left(self.container.pin.safeArea.left).right(self.container.pin.safeArea.right).bottom()
    }
}
