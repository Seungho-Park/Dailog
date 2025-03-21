//
//  Image+Extensions.swift
//  SharedUI
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public extension UIImage {
    static let bgLaunchScreen = UIImage(named: SharedUIAsset.Images.bgLaunchScreen.name, in: .module, with: nil)
    
    static let back = UIImage(named: "Back", in: .module, with: nil)
    static let forward = UIImage(named: "Forward", in: .module, with: nil)
    
    static let backHighlighted = UIImage(named: "BackHighlight", in: .module, with: nil)
    static let gallery = UIImage(named: "Gallery", in: .module, with: nil)
    static let camera = UIImage(named: "Camera", in: .module, with: nil)
    static let hideKeyboard = UIImage(named: "HideKeyboard", in: .module, with: nil)
    
    static let dropDown = UIImage(named: "DropDown", in: .module, with: nil)
    static let close = UIImage(named: "Close", in: .module, with: nil)
}
