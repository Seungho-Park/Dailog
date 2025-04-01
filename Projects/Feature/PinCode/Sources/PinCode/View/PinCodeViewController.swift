//
//  PinCodeViewController.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout
import FlexLayout
import FeaturePinCodeInterfaces
import SharedUI

public final class PinCodeViewController<VM: PinCodeViewModel>: DailogViewController<VM> {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 28, weight: .bold)
        label.textColor = .title
        label.text = "Input Passcode".localized
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .cursive(sizeOf: 20, weight: .medium)
        label.textColor = .title
        label.text = "4자리 숫자를 입력해주세요."
        return label
    }()
    
    private var pinLabels: [UILabel] = []
    private var enteredPin: String = ""
    private let keypadNumbers = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
            [-99, 0, -1]
        ]
    private let pinNumberButtonTapped: PublishRelay<Int> = .init()
    
    public override func configure() {
        super.configure()
        
        let pinContainer = UIView()
        pinContainer.flex.direction(.row).justifyContent(.center).define { flex in
            for _ in 0..<4 {
                let label = UILabel()
                label.text = "_"
                label.font = .cursive(sizeOf: 40, weight: .bold)
                label.textAlignment = .center
                label.textColor = .softCoral
                pinLabels.append(label)
                flex.addItem(label).width(35).marginHorizontal(10)
            }
        }
        
        let keypadContainer = UIView()
        keypadContainer
            .flex
            .define { flex in
            for row in keypadNumbers {
                flex
                    .addItem()
                    .direction(.row)
                    .grow(1)
                    .basis(0)
                    .define { rowFlex in
                        for title in row {
                            let button = makePinNumberButton(tag: title)
                            button.flex
                                .grow(1)
                                .basis(0)
                            rowFlex.addItem(button)
                        }
                }
            }
        }
        
        container
            .flex
            .direction(.column)
            .define { flex in
                flex.addItem()
                    .height(65%)
                    .define { flex in
                        flex.addItem(titleLabel).marginBottom(10)
                        flex.addItem(subtitleLabel).marginBottom(20)
                        flex.addItem(pinContainer)
                    }
                    .justifyContent(.center)
                
                flex.addItem()
                    .height(35%)
                    .define { flex in
                        flex.addItem(keypadContainer).grow(1)
                    }
            }
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                pinNumberPadTapped: pinNumberButtonTapped.asObservable()
            )
        )
        
        output.pinNumber
            .map { $0.count }
            .drive { [weak self] count in
                for i in 0..<count {
                    self?.pinLabels[i].text = "●"
                }
                
                for i in stride(from: 3, to: count-1, by: -1) {
                    self?.pinLabels[i].text = "_"
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func keypadButtonTapped(_ sender: UIButton) {
        pinNumberButtonTapped.accept(sender.tag)
    }
    
    private func updatePinDisplay() {
        for (index, label) in pinLabels.enumerated() {
            if index < enteredPin.count {
                label.text = "●"
            } else {
                label.text = "_"
            }
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

private extension PinCodeViewController {
    func makePinNumberButton(tag: Int)-> UIButton {
        let button = UIButton()
        button.tag = tag
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.image = tag == -1 ? .backspace?.resize(size: .init(width: 24, height: 24)) : nil
        if tag != -1 {
            config.attributedTitle = AttributedString(
                tag == -99 ? "Cancel".localized : "\(tag)",
                attributes: .init(
                    [
                        .font: UIFont.cursive(sizeOf: tag == -99 ? 22 : 24, weight: .medium),
                        .foregroundColor: UIColor.title
                    ]
                )
            )
        }
        button.configuration = config
        
        button.configurationUpdateHandler = { btn in
            btn.alpha = btn.state != .highlighted ? 1 : 0.6
        }
        
        button.addTarget(self, action: #selector(keypadButtonTapped(_:)), for: .touchUpInside)
        return button
    }
}
