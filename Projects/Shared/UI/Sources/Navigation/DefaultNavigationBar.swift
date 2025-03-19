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

open class DefaultNavigationBar: UIView, NavigationBar {
    public let container = UIView(frame: .zero)
    
    public var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    public let backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemName: "chevron.backward")?.withTintColor(.textColor, renderingMode: .alwaysOriginal), for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.textColor = .title
        label.text = "Title"
        label.font = .cursive(sizeOf: 24, weight: .bold)
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
        self.addSubview(container)
        
        container
            .flex
            .direction(.row)
            .paddingHorizontal(12)
            .alignItems(.center)
            .justifyContent(Locale.direction == .leftToRight ? .start : .end)
            .define { flex in
                flex.addItem(backButton)
                    .width(48)
                    .aspectRatio(1)
//                    .marginVertical(1)
                
                flex.addItem(titleLabel)
                    .position(.absolute)
                    .vertically(1)
                    .horizontally(0)
            }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout(mode: .fitContainer)
    }
}
