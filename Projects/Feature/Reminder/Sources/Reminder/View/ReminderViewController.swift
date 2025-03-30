//
//  ReminderViewController.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/30/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureReminderInterfaces
import RxSwift
import RxCocoa

public final class ReminderViewController<VM: ReminderViewModel>: DailogViewController<VM> {
    
    private let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 22, weight: .medium)
        label.textColor = .title
        return label
    }()
    
    private let leftArrowButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.contentInsets = .zero
        config.image = UIImage.back?.resize(size: .init(width: 24, height: 24))
        btn.configuration = config
        
        btn.configurationUpdateHandler = { btn in
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        return btn
    }()
    
    private let rightArrowButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.contentInsets = .zero
        config.image = UIImage.forward?.resize(size: .init(width: 24, height: 24))
        btn.configuration = config
        btn.configurationUpdateHandler = { btn in
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        return btn
    }()
    
    public override func configure() {
        super.configure()
        
        container
            .flex
            .addItem()
            .direction(.row)
            .justifyContent(.center)
            .alignItems(.center)
            .define { flex in
                flex.addItem(leftArrowButton)
                flex.addItem(dateLabel)
                
                    .marginHorizontal(20)
                flex.addItem(rightArrowButton)
            }
            .height(50)
    }
    
    public override func bind() {
        super.bind()
        let output = viewModel.transform(
            input: .init(
                prevDateButtonTapped: Locale.direction == .leftToRight ? leftArrowButton.rx.tap.asObservable() : rightArrowButton.rx.tap.asObservable(),
                nextDateButtonTapped: Locale.direction == .leftToRight ? rightArrowButton.rx.tap.asObservable() : leftArrowButton.rx.tap.asObservable()
            )
        )
        
        output.date
            .drive { [weak self] dateString in
                self?.dateLabel.text = dateString
                self?.dateLabel.flex.markDirty()
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
