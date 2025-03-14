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

open class DefaultNavigationBar: UIView, NavigationBar {
    public let container = UIView(frame: .zero)
    
    public var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    public let backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.navigationTitle, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = .title
        label.text = "Title"
        label.font = .ownglyph(sizeOf: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        self.backgroundColor = .clear
        
        self.flex
            .addItem(container)
            .direction(.row)
            .height(50)
            
        container
            .flex
            .addItem(backButton)
            .position(.absolute)
            .width(45)
            .vertically(1)
        
        container.flex
            .addItem(titleLabel)
            .position(.absolute)
            .horizontally(0)
            .vertically(1)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.pin.top().left().right().height(50)
        self.flex.layout(mode: .fitContainer)
    }
}
