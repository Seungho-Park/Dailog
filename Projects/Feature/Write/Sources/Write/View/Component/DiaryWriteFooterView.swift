//
//  DiaryWriteFooterView.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class DiaryWriteFooterView: UIView {
    
    private let container = UIView(frame: .zero)
    
    let showGalleryButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(.gallery, for: .normal)
        return btn
    }()
    
    let showCameraButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(.camera, for: .normal)
        return btn
    }()
    
    private let hideKeyboardButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setImage(.hideKeyboard, for: .normal)
        btn.isHidden = true
        return btn
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        self.addSubview(container)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willDismissKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        hideKeyboardButton.addTarget(self, action: #selector(hideKeyboardButtonTapped), for: .touchUpInside)
        
        container.flex
            .addItem()
            .define { flex in
                flex.addItem()
                    .height(1)
                    .backgroundColor(.separatorColor)
                    .marginBottom(10)
                
                flex.addItem()
                    .direction(.row)
                    .define { flex in
                        if Locale.direction == .leftToRight {
                            flex.addItem(showGalleryButton)
                                .height(30)
                                .width(30)
                            
                            flex.addItem(showCameraButton)
                                .width(30)
                                .height(30)
                                .marginLeft(7.5)
                            
                            flex.addItem()
                                .grow(1)
                            
                            flex.addItem(hideKeyboardButton)
                                .width(30)
                                .height(30)
                                .marginRight(7.5)
                        } else {
                            flex.addItem(hideKeyboardButton)
                                .width(30)
                                .height(30)
                                .marginLeft(7.5)
                            
                            flex.addItem()
                                .grow(1)
                            
                            flex.addItem(showCameraButton)
                                .width(30)
                                .height(30)
                                .marginRight(7.5)
                            
                            flex.addItem(showGalleryButton)
                                .height(30)
                                .width(30)
                                .marginLeft(7.5)
                        }
                    }
                    .alignItems(.start)
                    .marginHorizontal(12)
                    .marginBottom(10)
            }
    }
    
    @objc func willShowKeyboard(_ notification: Notification) {
        hideKeyboardButton.isHidden = false
    }
    
    @objc func willDismissKeyboard(_ notification: Notification) {
        hideKeyboardButton.isHidden = true
    }
    
    @objc func hideKeyboardButtonTapped() {
        self.superview?.endEditing(true)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
