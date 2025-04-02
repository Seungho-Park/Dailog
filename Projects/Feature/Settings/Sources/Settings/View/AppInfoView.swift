//
//  AppInfoView.swift
//  FeatureSettings
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class AppInfoView: UIView {
    private let container = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "App Information".localized
        label.font = .cursive(sizeOf: 16, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    private let appVersionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = "1.0.2"
        return label
    }()
    
    private lazy var privacyPolicyButton: UIButton = {
        let btn = UIButton()
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = "Privacy Policy".localized
        
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
    
    private lazy var termsButton: UIButton = {
        let btn = UIButton()
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = "Terms and conditions".localized
        
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
    
    private lazy var licenseButton: UIButton = {
        let btn = UIButton()
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = "Open Source License".localized
        
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
            .addItem()
            .direction(.row)
            .paddingHorizontal(20)
            .paddingVertical(12)
            .define { flex in
                flex.addItem(makeTitle("DAILOG Version".localized))
                    .grow(1)
                flex.addItem(appVersionLabel)
            }
        
        container
            .flex
            .addItem(termsButton)
        
        container
            .flex
            .addItem(privacyPolicyButton)
        
        container
            .flex
            .addItem(licenseButton)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout(mode: .adjustHeight)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeTitle(_ text: String)-> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .title
        label.text = text
        return label
    }
}
