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
        set { tabController.viewControllers = newValue }
    }
    
    public lazy var navigationBar = NavigationBar(frame: .zero)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        super.configure()
        
        self.view.layer.contents = UIImage.bgLaunchScreen?.cgImage
        
        self.addChild(tabController)
        self.container.addSubview(navigationBar)
        self.container.addSubview(tabController.view)
        tabController.didMove(toParent: self)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationBar.pin.top(self.view.pin.safeArea.top)
            .left().right()
            .height(50)
        
        tabController.view.pin
            .below(of: navigationBar)
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
