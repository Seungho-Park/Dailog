//
//  FilterNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/15/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

open class FilterNavigationBar: UIView, NavigationBar {
    public var title: String? = "전체"
    public let container: UIView = .init(frame: .zero)
    
    private lazy var filterTypeButton: UIButton = {
        let button = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        button.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            button.configuration?.baseBackgroundColor = .clear
            
            button.subviews
                .forEach {
                    guard let view = $0 as? UILabel else { return }
                    view.textColor = button.state == .highlighted ? .lightGray : .deepGray
                }
        }
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .apple(sizeOf: 18, weight: .bold)
        label.text = "전체"
        label.textColor = .deepGray
        return label
    }()
    
    private lazy var arrowLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12)
        label.text = "▼"
        label.textColor = .deepGray
        return label
    }()
    
    public convenience init(title: String? = nil) {
        self.init(frame: .zero)
        
        self.title = title
        configure()
    }
    
    public func configure() {
        self.addSubview(container)
        
        container.flex
            .addItem(filterTypeButton)
            .marginLeft(14)
            .grow(1)
            
        filterTypeButton.flex
            .direction(.row)
            .define { flex in
                flex.addItem(titleLabel)
                    .vertically(1)
                    .paddingRight(8)
                
                flex.addItem(arrowLabel)
                    .paddingLeft(8)
                    .marginBottom(1)
            }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
