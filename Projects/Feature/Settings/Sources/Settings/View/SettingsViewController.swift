//
//  SettingsViewController.swift
//  FeatureSettings
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SharedUI
import FeatureSettingsInterfaces

public final class SettingsViewController<VM: SettingsViewModel>: DailogViewController<VM> {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    public override func configure() {
        super.configure()
        
        container.addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all()
        contentView.pin.all()
        
        contentView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = contentView.frame.size
    }
}
