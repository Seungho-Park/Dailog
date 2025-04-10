//
//  MainViewController.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureMainInterfaces
import SharedUI
import GoogleMobileAds
import PinLayout

public final class MainViewController<VM: MainViewModel>: DailogViewController<VM>, UITabBarControllerDelegate, UIViewControllerAnimatedTransitioning {
    private lazy var tabController: UITabBarController = {
        let tabBar = UITabBarController()
        tabBar.view.backgroundColor = .clear
        tabBar.delegate = self
        return tabBar
    }()
    
    public var viewControllers: [UIViewController] {
        get { tabController.viewControllers ?? [] }
        set {
            tabController.viewControllers = newValue
        }
    }
    
    public override func viewDidLoad() {
//        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width
//        let adaptiveSize = currentOrientationAnchoredAdaptiveBanner(width: viewWidth)
//        bannerView = BannerView(adSize: adaptiveSize)
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
//        bannerView.rootViewController = self
        super.viewDidLoad()
        
//        bannerView.delegate = self
//        bannerView.load(Request())
    }
    
    public override func configure() {
        self.view.backgroundColor = .clear
        self.view.layer.contents = UIImage.bgLaunchScreen?.cgImage
        
        self.addChild(tabController)
        self.view.addSubview(tabController.view)
        tabController.didMove(toParent: self)
    }
    
    public override func viewDidLayoutSubviews() {
        tabController.view.pin
            .top(self.view.pin.safeArea)
            .left(self.view.pin.safeArea)
            .right(self.view.pin.safeArea)
            .bottom()
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> (any UIViewControllerAnimatedTransitioning)? {
        return self
    }
    
    public func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval {
        .zero
    }
    
    public func animateTransition(using transitionContext: any UIViewControllerContextTransitioning) {
        guard let view = transitionContext.view(forKey: .to)
        else {
            return
        }
            
        let container = transitionContext.containerView
        container.addSubview(view)

        transitionContext.completeTransition(true)
    }
}
