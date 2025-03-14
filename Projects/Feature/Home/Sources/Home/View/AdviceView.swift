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
        label.text = "Don't be afraid of failure. Enjoy the challenge."
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.text = "잭 웰치"
        label.textColor = .red
        return label
    }()
    
    private let authorDescLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.text = "전 GE 회장, 경영자"
        label.textColor = .red
        return label
    }()
    
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
            .padding(12)
            .alignItems(.center)
            .define { flex in
                flex.addItem(adviceLabel)
                flex.addItem(authorLabel)
                flex.addItem(authorDescLabel)
            }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.pin.all()
        self.containerView.flex.layout()
    }
}
