//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureHomeInterfaces
import RxSwift
import RxCocoa
import FlexLayout

public final class HomeViewController<VM: HomeViewModel>: DailogViewController<VM> {
    private let promptView: PromptView = PromptView(frame: .zero)
    private let adviceView: AdviceView = AdviceView(frame: .zero)
    
    private let writeButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        btn.configuration = config
        
        btn.configurationUpdateHandler = { btn in
            btn.configuration?.baseBackgroundColor = btn.state == .highlighted ?
                .softCoralHighlight : .softCoral
            
            btn.configuration?.attributedTitle = AttributedString(
                "Write Memory".localized,
                attributes: .init(
                    [
                        NSAttributedString.Key.font: UIFont.cursive(sizeOf: 24, weight: .medium),
                        NSAttributedString.Key.foregroundColor: btn.state == .highlighted ?
                        UIColor.component(255, 255, 255, 0.6) : UIColor.component(255, 255, 255)
                    ]
                )
            )
        }
        return btn
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        adviceView.alpha = 0
        promptView.alpha = 0
        writeButton.alpha = 0
    }
    
    public override func configure() {
        super.configure()
        
        container.flex
            .direction(.column)
            .marginHorizontal(12)
            .define { flex in
                flex.addItem()
                    .define { flex in
                        flex.addItem(adviceView)
                    }
                
                flex.addItem()
                    .define {
                        $0.addItem(promptView)
                    }
                    .marginBottom(10%)
                    .justifyContent(.end)
                    .grow(1)
                
                flex.addItem(writeButton)
                    .marginBottom(20)
                    .height(48)
            }
    }
    
    public override func bind() {
        super.bind()
        
        let output = self.viewModel.transform(
            input: .init(
                viewWillAppear: self.rx.viewWillAppear.map { _ in }.asObservable(),
                writeButtonTapped: writeButton.rx.tap.asObservable()
            )
        )
        
        output.prompt
            .drive { [weak self] prompt in
                self?.promptView.alpha = 0
                self?.writeButton.alpha = 0
                self?.showPromptWithAnimation()
                self?.promptView.title = prompt.title
                self?.promptView.subtitle = prompt.subtitle
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        output.advice
            .drive { [weak self] advice in
                self?.adviceView.alpha = 0
                self?.showAdiceWithAnimation()
                self?.adviceView.advice = advice.text
                self?.adviceView.author = "- \(advice.author.name)"
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func showAdiceWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.adviceView.alpha = 1
        }, completion: nil)
    }
    
    private func showPromptWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.promptView.alpha = 1
        })
        
        showWriteMemoryButtonWithAnimation()
    }
    
    private func showWriteMemoryButtonWithAnimation() {
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.writeButton.alpha = 1
        }, completion: nil)
    }
}
