//
//  SplashViewController.swift
//  Feature
//
//  Created by 박승호 on 7/2/25.
//

import UIKit
import SharedUI

public final class SplashViewController: DailogViewController<SplashViewModel> {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Georgia-Bold", size: 48)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "DAILOG"
        label.textColor = .black
        return label
    }()
    
    public override func configure() {
        super.configure()
        
        rootContainerView.flex
            .define { flex in
                flex.addItem(titleLabel)
            }
            .justifyContent(.center)
            .paddingBottom(30%)
    }
    
    public override func bind() {
        super.bind()
        
        let _ = viewModel.transform(input: .init())
    }
}
