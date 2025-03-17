//
//  EmptyDataView.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import SharedUIInterfaces

public final class EmptyDataView: UIView {
    private let container = UIView()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: .init(systemName: "text.page.slash")?.withTintColor(.deepGray, renderingMode: .alwaysOriginal))
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.text = "No diary data".localized
        label.textColor = .deepGray
        label.font = .cursive(sizeOf: 24, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.text = "Tap the + button below to write your diary".localized
        label.textColor = .deepGray
        label.font = .cursive(sizeOf: 16, weight: .medium)
        return label
    }()
    
    private let writeButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.filled()
        btn.configuration = config
        btn.layer.masksToBounds = true
        btn.configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(
                "+",
                attributes: .init(
                    [
                        NSAttributedString.Key.foregroundColor : btn.state != .highlighted ? UIColor.component(1, 1, 1).cgColor : UIColor.component(1, 1, 1, 0.6).cgColor,
                        NSAttributedString.Key.font: UIFont.cursive(sizeOf: 48, weight: .medium)
                    ]
                )
            )
            btn.configuration?.baseBackgroundColor = btn.state == .highlighted ? .softCoralHighlight : .softCoral
        }
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(container)
        
        container.flex
            .margin(20)
        
        container.flex
            .addItem()
            .justifyContent(.center)
            .alignItems(.center)
            .position(.absolute)
            .all(0)
            .define { flex in
                flex.addItem(imageView)
                    .width(100)
                    .height(125)
                    .marginBottom(15)
                
                flex.addItem(titleLabel)
                    .marginTop(15)
                flex.addItem(subtitleLabel)
                    .marginTop(10)
            }
            .marginBottom(40%)
        
        container
            .flex
            .addItem()
            .grow(1)
            .define { flex in
                flex.addItem(writeButton)
                    .width(60)
                    .height(60)
            }
            .justifyContent(Locale.direction == .leftToRight ? .end : .start)
            .alignItems(Locale.direction == .leftToRight ? .end : .start)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        writeButton.layer.cornerRadius = writeButton.frame.width/2
        container.pin.all()
        container.flex.layout()
    }
}
