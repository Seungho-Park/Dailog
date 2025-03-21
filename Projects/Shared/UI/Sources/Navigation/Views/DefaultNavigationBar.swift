//
//  NavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FlexLayout
import PinLayout
import RxSwift
import RxCocoa

public final class DefaultNavigationBar: NavigationBar {
    private let container = UIView()
    
    public init(title: String = "") {
        super.init(title: title)
        
        self.items.append(backButton)
        self.addSubview(container)
        configure()
    }
    
    private func configure() {
        container.flex
            .addItem()
            .direction(.row)
            .define { flex in
                flex.addItem(backButton)
                
            }
            .grow(1)
            .alignItems(.center)
            .justifyContent(Locale.direction == .leftToRight ? .start : .end)
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
