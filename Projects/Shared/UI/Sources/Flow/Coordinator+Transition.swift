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
        
    }
    
    func close(animated: Bool = true, completion: (()-> Void)? = nil) {
        
    }
}
