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

public final class HomeViewController<VM: HomeViewModel>: DailogViewController<VM> {
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .ownglyph(30, .bold)
        label.text = "오늘 하루는 어떠셨나요?"
        label.textColor = .title
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 1
        label.font = .ownglyph(28, .medium)
        label.text = "지금 느끼는 감정을 기록해보세요."
        label.textColor = .title
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print("prompt_title_1".prompt)
    }
    
    public override func configure() {
        super.configure()
        
        container.flex
            .addItem()
            .marginHorizontal(12)
            .define { flex in
                flex.addItem()
                    .marginTop(40)
                    .define { flex in
                        flex.addItem(titleLabel)
                            .marginBottom(3)
                        flex.addItem(subtitleLabel)
                            .marginTop(3)
                    }
            }
    }
    
    public override func bind() {
        super.bind()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
