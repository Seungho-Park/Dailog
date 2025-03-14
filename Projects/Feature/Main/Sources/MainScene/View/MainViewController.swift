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

public final class MainViewController<VM: MainViewModel>: DailogViewController<VM>, UITabBarControllerDelegate {
    private lazy var tabController: UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.view.backgroundColor = .clear
        return tabBar
    }()
    
    public var viewControllers: [UIViewController] {
        get { tabController.viewControllers ?? [] }
        set {
            tabController.viewControllers = newValue
            switch Locale.direction {
            case .leftToRight:
                if tabController.selectedIndex != 0 {
                    tabController.selectedIndex = 0
                }
            case .rightToLeft:
                if tabController.selectedIndex != newValue.count-1 {
                    tabController.selectedIndex = newValue.count-1
                }
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        self.view.backgroundColor = .clear
        self.view.layer.contents = UIImage.bgLaunchScreen?.cgImage
        
        self.addChild(tabController)
        self.view.addSubview(tabController.view)
        tabController.didMove(toParent: self)
        
        tabController.view.addSubview(container)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabController.view.pin
            .top(self.container.pin.safeArea.top)
            .left(self.container.pin.safeArea.left)
            .right(self.container.pin.safeArea.right)
            .bottom()
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Select: \(viewController.self)")
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Select2: \(viewController.self)")
        return true
    }
}
