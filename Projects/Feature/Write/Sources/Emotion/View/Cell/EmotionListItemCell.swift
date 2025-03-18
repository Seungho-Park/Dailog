//
//  EmotionListItemCell.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import DomainWriteInterfaces

public final class EmotionListItemCell: UICollectionViewCell {
    public static let identifier = "EmotionListItemCell"
    
    private let container = UIView()
    
    private let emotionDescLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .deepGray
        return label
    }()
    
    private let emotionImageLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 48, weight: .bold)
        label.textAlignment = Locale.direction == .leftToRight ? .right : .left
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOpacity = 0.8
        contentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        contentView.layer.shadowRadius = 3
        
        container.backgroundColor = .cream
        self.contentView.addSubview(container)
        
        self.container.layer.cornerRadius = 8
        
        container
            .flex
            .addItem()
            .define { flex in
                flex.addItem(emotionDescLabel)
                flex.addItem(emotionImageLabel)
                    .grow(1)
            }
            .grow(1)
            .margin(12)
    }
    
    public func fill(emotion: Emotion) {
        emotionDescLabel.text = emotion.string
        emotionImageLabel.text = emotion.emoji
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    public override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                container.alpha = 0.6
            } else {
                container.alpha = 1
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
