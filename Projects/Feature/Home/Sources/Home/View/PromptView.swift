//
//  PromptView.swift
//  FeatureHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public final class PromptView: UIView {
    private let containerView = UIView(frame: .zero)
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 0
        label.font = .cursive(sizeOf: 28, weight: .bold)
        label.textColor = .title
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 0
        label.font = .cursive(sizeOf: 24, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    public var title: String {
        get { return titleLabel.text ?? "" }
        set {
            titleLabel.text = newValue
            titleLabel.flex.markDirty()
            containerView.flex.layout()
        }
    }
    
    public var subtitle: String {
        get { subtitleLabel.text ?? "" }
        set {
            subtitleLabel.text = newValue
            subtitleLabel.flex.markDirty()
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
        self.backgroundColor = .clear
        self.addSubview(containerView)
        
        self.containerView.flex
            .addItem()
            .direction(.column)
            .define { flex in
                flex.addItem(titleLabel)
                    .marginBottom(6)
                
                flex.addItem(subtitleLabel)
                    .marginTop(6)
            }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.pin.all()
        self.containerView.flex.layout()
    }
}

public extension Reactive where Base == PromptView {
    var title: Binder<String> {
        return Binder(base) { view, newValue in
            view.title = newValue
        }
    }
    
    var subtitle: Binder<String> {
        return Binder(base) { view, newValue in
            view.subtitle = newValue
        }
    }
}
