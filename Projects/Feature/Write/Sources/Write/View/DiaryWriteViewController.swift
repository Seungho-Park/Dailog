//
//  DiaryWriteViewController.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import RxSwift
import RxCocoa
import FeatureWriteInterfaces

public final class DiaryWriteViewController<VM: DiaryWriteViewModel>: DailogViewController<VM> {
    
    private let headerView = DiaryWriteHeaderView(frame: .zero)
    private let footerView = DiaryWriteFooterView(frame: .zero)
    
    private let textView = TextView(frame: .zero)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        self.navigationBar = DefaultNavigationBar(title: "")
        super.configure()
        
        container.flex
            .addItem()
            .grow(1)
            .define { flex in
                flex.addItem(headerView)
                flex.addItem(textView)
                    .marginVertical(10)
                    .marginHorizontal(12)
                    .grow(1)
                flex.addItem(footerView)
            }
    }
    
    public override func bind() {
        super.bind()
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe { [weak self] notification in
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                    self?.footerView.flex
                        .marginBottom(keyboardFrame.height - (self?.view.safeAreaInsets.bottom ?? 0))
                    
                    self?.footerView.flex.markDirty()
                    self?.container.flex.layout()
                }
                
            }
            .disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .subscribe { [weak self] notification in
                self?.footerView.flex
                    .marginBottom(0)
                
                self?.footerView.flex.markDirty()
                self?.container.flex.layout()
            }
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(
            input: .init(
                backButtonTapped: navigationBar?.rx.tap.filter { $0 == .back }.map { _ in }.asObservable(),
                emotionButtonTapped: headerView.emotionButton.rx.tap.asObservable(),
                addPhotoButtonTapped: footerView.showGalleryButton.rx.tap.asObservable(),
                captureCameraButtonTapped: footerView.showCameraButton.rx.tap.asObservable()
            )
        )
        
        output.emotion
            .distinctUntilChanged()
            .drive(headerView.rx.emotion)
            .disposed(by: disposeBag)
    }
}
