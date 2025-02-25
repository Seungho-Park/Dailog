//
//  DailogView.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public class DailogView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
//        self.layer.contents = UIImage.bgLaunchScreen?.cgImage
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
}
