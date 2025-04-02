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
        let imageView = UIImageView(image: .init(systemName: "text.page.slash")?.withTintColor(.textColor, renderingMode: .alwaysOriginal))
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.text = "No diary data".localized
        label.textColor = .textColor
        label.font = .cursive(sizeOf: 28, weight: .bold)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.text = "Tap the + button below to write your diary".localized
        label.textColor = .textColor
        label.font = .cursive(sizeOf: 18, weight: .medium)
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
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
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
