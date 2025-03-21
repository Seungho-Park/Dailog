//
//  NavigationBarButton.swift
//  SharedUI
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

open class NavigationBarButton: UIButton {
    var type: NavigationItem
    
    public init(type: NavigationItem) {
        self.type = type
        super.init(frame: .zero)
        isUserInteractionEnabled = true
    }
    
    private override init(frame: CGRect) {
        type = .back
        super.init(frame: frame)
        isUserInteractionEnabled = true
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
