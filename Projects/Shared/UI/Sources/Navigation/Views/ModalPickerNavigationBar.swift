//
//  ModalPickerNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/21/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class ModalPickerNavigationBar: NavigationBar {
    private let container = UIView()
    public override var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var cancelButton: NavigationBarButton = {
        let button = NavigationBarButton(type: .back)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        
        button.configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(
                "Cancel".localized,
                attributes: .init([
                    .font: UIFont.cursive(sizeOf: 18, weight: .medium),
                    .foregroundColor: btn.state != .highlighted ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
                ])
            )
        }
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Title"
        label.textAlignment = .center
        label.font = .cursive(sizeOf: 22, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private lazy var selectButton: NavigationBarButton = {
        let button = NavigationBarButton(type: .confirm)
        var config = UIButton.Configuration.plain()
        button.configuration = config
        
        button.configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(
                "Select".localized,
                attributes: .init([
                    .font: UIFont.cursive(sizeOf: 18, weight: .medium),
                    .foregroundColor: btn.state != .highlighted ? UIColor.white : UIColor.white.withAlphaComponent(0.6)
                ])
            )
        }
        button.isEnabled = false
        return button
    }()
    
    public var canSelect: Bool {
        get { selectButton.isEnabled }
        set {
            selectButton.isEnabled = newValue
        }
    }
    
    convenience public init(title: String) {
        self.init(items: [], title: title)
        items.append(cancelButton)
        items.append(selectButton)
        configure()
    }
    
    private func configure() {
        self.addSubview(container)
        titleLabel.text = title
        container
            .flex
            .backgroundColor(.softCoral)
            .addItem()
            .grow(1)
            .direction(.row)
            .alignItems(.center)
            .define { flex in
                flex.addItem(cancelButton)
                flex.addItem(titleLabel)
                    .position(.absolute)
                    .horizontally(0)
                    .vertically(0)
                flex.addItem().grow(1)
                flex.addItem(selectButton)
            }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
