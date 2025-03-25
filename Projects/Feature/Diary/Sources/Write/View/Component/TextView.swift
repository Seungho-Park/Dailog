//
//  TextView.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public final class TextView: UIView, UITextViewDelegate {
    private let container = UIView()
    
    let textView: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = .clear
        view.font = .cursive(sizeOf: 20, weight: .medium)
        view.textColor = .textColor
        view.contentInset = .zero
        view.textContainerInset = .zero
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
    
    public var text: String? {
        get { textView.text }
        set {
            textView.text = newValue
            placeHolderLabel.isHidden = !(textView.text ?? "").isEmpty
        }
    }
    
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
                        .top(0)
                } else {
                    flex.addItem(placeHolderLabel)
                        .position(.absolute)
                        .right(5.5)
                        .top(0)
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

public extension Reactive where Base: TextView {
    var text: ControlProperty<String?> {
        return base.textView.rx.text
    }
}
