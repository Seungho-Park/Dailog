//
//  Coordinator.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    @discardableResult
    func start()-> UIViewController
    
    @discardableResult
    func transition(scene: Scene, transitionStyle: TransitionStyle, animated: Bool)-> UIViewController
    func close(animated: Bool, completion: (()-> Void)?)
}

public extension Coordinator {
    @discardableResult
    func transition(scene: Scene, transitionStyle: TransitionStyle, animated: Bool)-> UIViewController {
        let vc = scene.instantiate()
        
        switch transitionStyle {
        case .root:
            let completion = {
                if let transitionCoordinator = navigationController.transitionCoordinator {
                    transitionCoordinator.animate(alongsideTransition: nil) { _ in
                        navigationController.viewControllers = [vc]
                    }
                } else {
                    navigationController.setViewControllers([vc], animated: false)
                }
            }
            
            if animated {
                if navigationController.viewControllers.count > 1 {
                    navigationController.viewControllers.insert(vc, at: navigationController.viewControllers.count-1)
                    navigationController.popViewController(animated: true)
                } else {
                    navigationController.pushViewController(vc, animated: true)
                }
            }
            
            completion()
        case .push:
            navigationController.pushViewController(vc, animated: animated)
        case .modal:
            navigationController.visibleViewController?.present(vc, animated: animated)
        }
        
        return vc
    }
    
    func close(animated: Bool, completion: (()-> Void)? = nil) {
        if navigationController.visibleViewController?.presentingViewController != nil {
            navigationController.visibleViewController?.dismiss(animated: animated, completion: completion)
        } else if navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: animated)
        }
    }
}
