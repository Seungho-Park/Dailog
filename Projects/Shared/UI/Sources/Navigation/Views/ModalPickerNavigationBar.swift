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
        button.setTitle("Cancel".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Title"
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var selectButton: NavigationBarButton = {
        let button = NavigationBarButton(type: .confirm)
        button.setTitle("Select".localized, for: .normal)
        button.setTitleColor(.black, for: .normal)
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
            .backgroundColor(.cyan)
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
