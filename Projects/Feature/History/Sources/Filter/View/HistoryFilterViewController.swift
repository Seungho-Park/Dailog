//
//  HistoryFilterViewController.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PinLayout
import FlexLayout
import SharedUI
import FeatureHistoryInterfaces

public final class HistoryFilterViewController<VM: HistoryFilterViewModel>: DailogViewController<VM>, UIPickerViewDataSource, UIPickerViewDelegate {
    private let outsideView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .component(0, 0, 0, 0.6)
        return view
    }()
    
    private let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["All".localized, "Year".localized, "Month".localized])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .cream
        control.selectedSegmentTintColor = .softCoral
        control.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        control.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.cursive(sizeOf: 18, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.deepGray], for: .normal)
        control.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.cursive(sizeOf: 18, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.component(255, 255, 255, 1)], for: .selected)
        return control
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
    
    private var filterType: HistoryFilterType = .all
    private var years: [String] = []
    private var months: [String] = []
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView(frame: .zero)
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()
    
    convenience public init(viewModel: VM) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public override func configure() {
        self.view.addSubview(outsideView)
        self.view.addSubview(container)
        
        outsideView.alpha = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedOutside))
        self.outsideView.addGestureRecognizer(tap)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        container.addGestureRecognizer(panGesture)
        
        container.backgroundColor = .white
        container.layer.cornerRadius = 15
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        container
            .flex
            .define { flex in
                flex.addItem(segmentControl)
                    .margin(12)
                    .height(45)
                
                flex.addItem(pickerView)
                    .grow(1)
                    .marginBottom(12)
                
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
                segmentChanged: segmentControl.rx.selectedSegmentIndex.asObservable(),
                didSelectedPicker: pickerView.rx.itemSelected.map { (row: $0.row, component: $0.component) }.asObservable(),
                applyButtonTapped: applyButton.rx.tap.asObservable()
            )
        )
        
        output.filterType
            .map { $0.rawValue }
            .drive(segmentControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        output.filterType
            .drive { [weak self]
                type in self?.filterType = type
                self?.pickerView.reloadAllComponents()
            }
            .disposed(by: disposeBag)
        
        output.years
            .drive { [weak self] in self?.years = $0 }
            .disposed(by: disposeBag)
        
        output.months
            .drive { [weak self] in self?.months = $0 }
            .disposed(by: disposeBag)
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            if filterType == .all {
                return 1
            } else if filterType == .month && Locale.dateType == .mm_yyyy {
                return months.count
            } else {
                return years.count
            }
        } else {
            if Locale.dateType == .mm_yyyy {
                return years.count
            } else {
                return months.count
            }
        }
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return filterType == .month ? 2 : 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel(frame: .zero)
        label.adjustsFontSizeToFitWidth = true
        label.font = .cursive(sizeOf: 26, weight: .medium)
        
        let componentSize = pickerView.rowSize(forComponent: component)
        label.frame = CGRect(x: 0, y: 0, width: componentSize.width - 20, height: componentSize.height)
        
        if component == 0 {
            if filterType == .all {
                label.text = "All".localized
            } else {
                if filterType == .month && Locale.dateType == .mm_yyyy {
                    label.text = "\(months[row])"
                } else {
                    label.text = "\(years[row])"
                }
            }
            
            if filterType != .month { label.textAlignment = .center }
            else {
                switch Locale.direction {
                case .leftToRight: label.textAlignment = .right
                case .rightToLeft: label.textAlignment = .left
                }
            }
        } else {
            if Locale.dateType == .mm_yyyy {
                label.text = "\(years[row])"
            } else {
                label.text = "\(months[row])"
            }
            switch Locale.direction {
            case .leftToRight: label.textAlignment = .left
            case .rightToLeft: label.textAlignment = .right
            }
        }
        
        return label
    }
    
    @objc
    private func touchedOutside() {
        dismiss(animated: false)
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
                dismiss(animated: false, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.container.frame.origin.y = viewHeight - containerHeight
                }
            }
        default: break
        }
    }
    
    public override func viewDidLayoutSubviews() {
        outsideView.pin.all()
        
        container.pin
            .below(of: self.view)
            .left()
            .right()
            .height(45%)
        
        applyButton.flex
            .marginBottom(container.safeAreaInsets.bottom)
        
        container.flex.layout()
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.outsideView.alpha = 1
            
            container.pin
                .left().right()
                .bottom()
                .height(45%)
        }
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
