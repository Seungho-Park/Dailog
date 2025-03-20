//
//  SplashViewController.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import UIKit
import SharedUI
import FeatureSplashInterfaces
import FlexLayout
import PinLayout

public final class SplashViewController<VM: SplashViewModel>: DailogViewController<VM> {
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "AppName".localized
        label.numberOfLines = 1
        label.font = .serif(sizeOf: 56, weight: .bold).italic
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "AppSubTitle".localized
        label.numberOfLines = 1
        label.font = .jalnan(17)
        return label
    }()
    
    private let contentsView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func configure() {
        super.configure()
        
        container.flex.addItem(contentsView)
        contentsView
            .flex
            .addItem()
            .alignItems(.center)
            .define { flex in
                flex.addItem(titleLabel)
                    .marginBottom(12.5)
                flex.addItem(subTitleLabel)
                    .marginTop(12.5)
            }
    }
    
    public override func bind() {
        super.bind()
        
        _ = viewModel.transform(
            input: .init(
                viewDidAppear: self.rx.viewDidAppear.map { _ in }.asObservable()
            )
        )
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        contentsView
            .pin
            .vCenter(-7.4%)
    }
}
