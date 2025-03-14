//
//  NavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public protocol NavigationBar: UIView {
    var container: UIView { get }
    
    var title: String? { get set }
    
    func configure()
}
