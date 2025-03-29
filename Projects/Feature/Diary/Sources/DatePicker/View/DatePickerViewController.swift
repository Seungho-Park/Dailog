//
//  DatePickerViewController.swift
//  FeatureDiary
//
//  Created by 박승호 on 3/29/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FlexLayout
import PinLayout
import SharedUI
import FeatureDiaryInterfaces

public final class DatePickerViewController<VM: DatePickerViewModel>: DailogViewController<VM> {
    private lazy var outsideView = {
        let view = UIView(frame: .zero)
        view.alpha = 0
        view.backgroundColor = .component(0, 0, 0, 0.6)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedOutside))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var applyButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        btn.configuration = config
        
        btn.configurationUpdateHandler = { btn in
            btn.configuration?.baseBackgroundColor = btn.state == .highlighted ? UIColor.softCoralHighlight : UIColor.softCoral
            btn.configuration?.attributedTitle = AttributedString(
                "Apply".localized,
                attributes: .init(
                    [
                        NSAttributedString.Key.font: UIFont.cursive(sizeOf: 24, weight: .medium),
                        NSAttributedString.Key.foregroundColor : btn.state == .highlighted ? UIColor.component(255, 255, 255, 0.8) : UIColor.component(255, 255, 255)
                    ]
                )
            )
        }
        return btn
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.locale = Locale.getLocaleFromLangCode()
        picker.tintColor = .softCoral
        return picker
    }()
    
    private var isInitial = false
    private let dismissAction: PublishRelay<Void> = .init()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func configure() {
        self.view.addSubview(outsideView)
        self.view.addSubview(container)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        container.addGestureRecognizer(panGesture)
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 15
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        container
            .flex
            .define { flex in
                flex.addItem(datePicker)
                    .marginHorizontal(12)
                    .marginBottom(12)
                    .grow(1)
                
                flex.addItem(applyButton)
                    .marginBottom(container.flex.view?.safeAreaInsets.bottom ?? 0)
                    .marginHorizontal(12)
                    .height(48)
            }
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                dismissAction: dismissAction.asObservable(),
                applyButtonTapped: applyButton.rx.tap.withUnretained(self).map { owner, _ in
                    owner.datePicker.date
                }.asObservable()
            )
        )
        
        output.date
            .drive(datePicker.rx.date)
            .disposed(by: disposeBag)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        let velocity = gesture.velocity(in: gesture.view!)
        
        let viewHeight = view.frame.height
        let containerHeight = container.frame.height

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                container.frame.origin.y = viewHeight - containerHeight + translation.y
            }
        case .ended:
            if velocity.y > 1000 {
                dismissAction.accept(())
            } else {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.container.frame.origin.y = viewHeight - containerHeight
                }
            }
        default: break
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    public override func viewDidLayoutSubviews() {
        if !isInitial {
            outsideView.pin.all()
            
            container.pin
                .below(of: self.view)
                .left(self.view.pin.safeArea)
                .right(self.view.pin.safeArea)
            
            applyButton.flex
                .marginBottom(container.safeAreaInsets.bottom)
            
            container.flex.layout(mode: .adjustHeight)
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let self = self else { return }
                self.outsideView.alpha = 1
                
                container.pin
                    .left(self.view.pin.safeArea)
                    .right(self.view.pin.safeArea)
                    .bottom()
                
                container.flex.layout(mode: .adjustHeight)
            }
            
            isInitial = true
        }
    }
    
    @objc
    private func touchedOutside() {
        dismissAction.accept(())
    }
    
    public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            outsideView.alpha = 0
            
            container.pin
                .below(of: self.view)
                .left()
                .right()
        } completion: { _ in
            super.dismiss(animated: false, completion: completion)
        }
    }
}
