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
        self.navigationBar = DefaultNavigationBar(title: "Settings".localized)
        super.configure()
        
        container.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView
            .flex
            .addItem(SystemSettingView(frame: .zero))
        
        contentView
            .flex
            .addItem()
            .height(0.5)
            .marginVertical(20)
            .backgroundColor(.lightGray)
        
        contentView
            .flex
            .addItem(SecuritySettingView(frame: .zero))
        
        contentView
            .flex
            .addItem()
            .height(0.5)
            .marginVertical(20)
            .backgroundColor(.lightGray)
        
        contentView
            .flex
            .addItem(AppInfoView(frame: .zero))
        
        contentView
            .flex.addItem().backgroundColor(.cyan)
            .height(500)
    }
    
    public override func bind() {
        super.bind()
        
//        rx.viewDidAppear.subscribe { [weak self] _ in
//            _ = self?.viewModel.transform(input: .init())
//        }
//        .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin.all()
        contentView.pin.all()
        
        contentView.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = contentView.frame.size
    }
}
