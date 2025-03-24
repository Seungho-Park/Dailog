//
//  NavigationBarFilterButton.swift
//  SharedUI
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public final class NavigationBarSelectButton: NavigationBarButton {
    private let container = UIView()
    
    public var text: String? {
        get { textLabel.text }
        set { textLabel.text = newValue }
    }
    
    public var font: UIFont! {
        get { textLabel.font }
        set { textLabel.font = newValue }
    }
    
    private lazy var textLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .apple(sizeOf: 18, weight: .bold)
        label.text = "전체"
        label.textColor = .textColor
        label.font = .cursive(sizeOf: 22, weight: .bold)
        return label
    }()
    
    private lazy var dropDownImage: UIImageView = {
        let view = UIImageView(image: .dropDown)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    public override init(type: NavigationItem = .filter) {
        super.init(type: type)
        
        container.isUserInteractionEnabled = false
        self.configuration = .plain()
        self.configurationUpdateHandler = { [weak self] btn in
            self?.textLabel.textColor = btn.state != .highlighted ? .textColor : .textColor.withAlphaComponent(0.6)
            self?.dropDownImage.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        
        configure()
    }
    
    private func configure() {
        self.addSubview(container)
        
        container
            .flex
            .addItem()
            .direction(.row)
            .grow(1)
            .define { flex in
                if Locale.direction == .leftToRight {
                    flex.addItem(textLabel)
                        .vertically(1)
                    
                    flex.addItem(dropDownImage)
                        .width(18)
                        .height(18)
                } else {
                    flex.addItem(dropDownImage)
                        .width(18)
                        .height(18)
                        .marginRight(5)
                    
                    flex.addItem(textLabel)
                        .vertically(1)
                }
            }
            .alignItems(.center)
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
