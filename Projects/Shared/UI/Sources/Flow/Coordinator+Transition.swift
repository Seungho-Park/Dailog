//
//  Coordinator+Transition.swift
//  SharedUI
//
//  Created by 박승호 on 6/30/25.
//

import UIKit

public enum TransitionStyle {
    case root
    case push
    case modal
}

public extension Coordinator {
    func transition(_ vc: UIViewController, style: TransitionStyle, animated: Bool = true) {
        switch style {
        case .root:
            navigationController.setViewControllers([vc], animated: animated)
        case .push:
            navigationController.pushViewController(vc, animated: animated)
        case .modal:
            let currentVC = navigationController.visibleViewController ?? navigationController
            currentVC.present(vc, animated: animated)
        }
    }
    
    func close(animated: Bool = true, completion: (()-> Void)? = nil) {
        let currentVC = navigationController.visibleViewController ?? navigationController
        
        if let presentedVC = currentVC.presentedViewController {
            presentedVC.dismiss(animated: animated, completion: completion)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
}
