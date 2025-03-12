//
//  NavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class NavigationBar: UIView {
    
    public lazy var alarmButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "bell")?.withTintColor(.icon, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .clear
        
        self.flex
            .direction(.row)
            .define { flex in
                flex.addItem().grow(1)
                flex.addItem().direction(.row)
                    .define { flex in
                        flex.addItem(alarmButton)
                    }
            }
            .padding(5, 15, 5, 15)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.flex.layout(mode: .fitContainer)
    }
}
