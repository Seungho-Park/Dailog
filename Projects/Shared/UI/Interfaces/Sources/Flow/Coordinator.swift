//
//  Coordinator.swift
//  SharedUI
//
//  Created by 박승호 on 6/27/25.
//

import UIKit

public protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    @discardableResult
    func start()-> UIViewController
}
