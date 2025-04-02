//
//  SystemSettingView.swift
//  FeatureSettings
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class SystemSettingView: UIView {
    
    private let container = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "System Settings".localized
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    private lazy var notiSettingButton: UIButton = {
        let btn = UIButton()
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = "Notifications".localized
        
        btn.flex
            .direction(.row)
            .define { flex in
                flex.addItem(label).grow(1)
                flex.addItem(UIImageView(image: .forward?.resize(size: .init(width: 16, height: 16))))
            }
            .paddingHorizontal(20)
            .paddingVertical(12)
        
        btn.configurationUpdateHandler = { btn in
            btn.backgroundColor = btn.state == .highlighted ? .black.withAlphaComponent(0.15) : .clear
        }
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        container
            .flex
            .addItem(titleLabel)
            .marginHorizontal(12)
            .marginBottom(16)
        
        container
            .flex
            .addItem(notiSettingButton)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout(mode: .adjustHeight)
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
