//
//  AdviceView.swift
//  FeatureHome
//
//  Created by 박승호 on 3/15/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class AdviceView: UIView {
    private let containerView: UIView = UIView(frame: .zero)
    
    private let adviceLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 12, weight: .regular)
        label.textColor = .title
        return label
    }()
    
    private let authorDescLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 12, weight: .regular)
        label.textColor = .title
        return label
    }()
    
    public var advice: String {
        get { adviceLabel.text ?? "" }
        set {
            adviceLabel.text = newValue
            adviceLabel.flex.markDirty()
            containerView.flex.layout()
        }
    }
    
    public var author: String? {
        get { authorLabel.text ?? "" }
        set {
            authorLabel.text = newValue
            authorLabel.flex.markDirty()
            containerView.flex.layout()
        }
    }
    
    public var desc: String {
        get { authorDescLabel.text ?? "" }
        set {
            authorDescLabel.text = newValue
            authorDescLabel.flex.markDirty()
            containerView.flex.layout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.addSubview(containerView)
        
        self.containerView.flex
            .direction(.column)
            .alignItems(Locale.direction == .leftToRight ? .end : .start)
            .define { flex in
                flex.addItem(adviceLabel)
                    .paddingBottom(8)
                flex.addItem(authorLabel)
//                    .paddingBottom(6)
//                flex.addItem(authorDescLabel)
            }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.pin.all()
        self.containerView.flex.layout()
    }
}
