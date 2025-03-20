//
//  NavigationBackButton.swift
//  SharedUI
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public final class NavigationBackButton: NavigationBarButton {
    private let container = UIView()
    
    let backImage: UIImageView = {
        let view = UIImageView(image: .back)
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        return view
    }()
    
    public override init(type: NavigationItem = .back) {
        super.init(type: type)
        
        configure()
    }
    
    private func configure() {
        self.addSubview(container)
        
        container.flex
            .addItem()
            .grow(1)
            .define { flex in
                flex.addItem(backImage)
                    .width(26)
                    .height(26)
            }
            .marginLeft(8)
            .justifyContent(.center)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
