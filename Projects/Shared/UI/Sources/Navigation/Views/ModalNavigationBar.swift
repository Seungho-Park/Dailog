//
//  ModalNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/30/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public final class ModalNavigationBar: NavigationBar {
    private let closeButton: NavigationBarButton = {
        let button = NavigationBarButton(type: .back)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(
                "x",
                attributes: .init([
                    .font: UIFont.cursive(sizeOf: 36, weight: .medium),
                    .foregroundColor: btn.state != .highlighted ? UIColor.title : UIColor.title.withAlphaComponent(0.6)
                ])
            )
        }
        return button
    }()
    
    public init() {
        super.init(title: "")
        items.append(closeButton)
        
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
    
    private func configure() {
        self.flex
            .define { flex in
                flex.addItem(closeButton)
                    .width(48)
                    .height(48)
                    .paddingEnd(12)
            }
            .alignItems(Locale.direction == .leftToRight ? .end : .start)
            .justifyContent(.center)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flex.layout()
    }
}
