//
//  TextView.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class TextView: UIView, UITextViewDelegate {
    private let container = UIView()
    
    private let textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = .clear
        view.font = .cursive(sizeOf: 20, weight: .medium)
        view.textColor = .deepGray
        view.contentInset = .zero
        view.textAlignment = Locale.direction == .leftToRight ? .left : .right
        return view
    }()
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.text = "Write Diary PlaceHolder".localized
        label.font = .cursive(sizeOf: 20, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .placeholderText
        return label
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        textView.delegate = self
        container
            .flex
            .define { flex in
                flex.addItem(textView)
                    .grow(1)
                
                if Locale.direction == .leftToRight {
                    flex.addItem(placeHolderLabel)
                        .position(.absolute)
                        .left(5.5)
                        .top(7.5)
                } else {
                    flex.addItem(placeHolderLabel)
                        .position(.absolute)
                        .right(5.5)
                        .top(7.5)
                }
            }
            .margin(12)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        placeHolderLabel.isHidden = !(textView.text ?? "").isEmpty
    }
}
