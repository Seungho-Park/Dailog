//
//  EmotionButton.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import DomainDiaryInterfaces
import RxCocoa
import RxSwift

public final class EmotionButton: UIView {
    let container = {
        let button = UIButton(frame: .zero)
        let config = UIButton.Configuration.plain()
        button.configuration = config
        
        button.configurationUpdateHandler = { button in
            button.subviews.forEach {
                guard let label = $0 as? UILabel else { return }
                let color = button.state != .highlighted ? label.textColor.withAlphaComponent(1) : label.textColor.withAlphaComponent(0.6)
                label.textColor = color
            }
        }
        
        return button
    }()
    
    private let emotionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .textColor
        label.text = "😀"
        return label
    }()
    
    private let emotionDescLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .textColor
        label.text = "Happy".localized
        return label
    }()
    
    public var selected: Emotion? = nil {
        didSet {
            emotionDescLabel.text = selected == nil ? "Not Selected".localized : selected!.string
            emotionLabel.text = selected == nil ? "🫥" : selected!.emoji
            
            emotionLabel.flex.markDirty()
            emotionDescLabel.flex.markDirty()
            container.flex.layout()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        container.flex
            .direction(.row)
            .define { flex in
                flex.addItem(emotionLabel)
                    .marginRight(2.5)
                
                flex.addItem(emotionDescLabel)
                    .marginLeft(2.5)
            }
            .alignItems(.center)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: EmotionButton {
    var tap: ControlEvent<Void> {
        return self.base.container.rx.tap
    }
}
