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

public final class HomeViewController<VM: HomeViewModel>: DailogViewController<VM> {
    private let promptView: PromptView = PromptView(frame: .zero)
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func configure() {
        super.configure()
        
        container.flex
            .addItem()
            .marginHorizontal(12)
            .define { flex in
                flex.addItem(promptView)
            }
    }
    
    public override func bind() {
        super.bind()
        
        let output = self.viewModel.transform(input: .init())
        
        output.prompt
            .drive { [weak self] prompt in
                self?.promptView.title = prompt.title
                self?.promptView.subtitle = prompt.subtitle
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
