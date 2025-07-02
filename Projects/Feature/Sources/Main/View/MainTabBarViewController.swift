//
//  MainTabBarViewController.swift
//  Feature
//
//  Created by 박승호 on 7/2/25.
//

import UIKit
import SharedUI

public final class MainTabBarViewController: DailogViewController<MainTabBarViewModel> {
    private let tabBarVC: UITabBarController = {
        let tabBarController = UITabBarController()
        tabBarController.view.backgroundColor = .clear
        return tabBarController
    }()
    
    public var viewControllers: [UIViewController] = [] {
        didSet {
            tabBarVC.setViewControllers(viewControllers, animated: true)
        }
    }
    
    public override func viewDidLoad() {
        self.addChild(tabBarVC)
        super.viewDidLoad()
    }
    
    public override func configure() {
        rootContainerView.flex
            .define { flex in
                flex.addItem(self.tabBarVC.view)
            }
            .grow(1)
        
        tabBarVC.didMove(toParent: self)
    }
}
