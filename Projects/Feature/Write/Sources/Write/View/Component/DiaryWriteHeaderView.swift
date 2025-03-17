//
//  DiaryWriteHeaderView.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class DiaryWriteHeaderView: UIView {
    private let container = UIView(frame: .zero)
    
    private let emotionButton = EmotionButton(frame: .zero)
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.text = "2025.03.17(월)"
        label.textColor = .deepGray
        label.font = .cursive(sizeOf: 18, weight: .medium)
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        container.flex.addItem()
            .direction(.row)
            .define { flex in
                flex.addItem(emotionButton)
                flex.addItem().grow(1)
                flex.addItem(dateLabel)
            }
            .paddingHorizontal(12)
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
