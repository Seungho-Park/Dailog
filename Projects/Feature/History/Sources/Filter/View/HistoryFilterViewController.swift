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
    private lazy var outsideView = {
        let view = UIView(frame: .zero)
        view.alpha = 0
        view.backgroundColor = .component(0, 0, 0, 0.6)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchedOutside))
        view.addGestureRecognizer(tap)
        
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
    
    private let tapOutside: PublishRelay<Void> = .init()
    private var years: [Int] = []
    private var months: [Int] = []
    
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
        
        segmentControl.rx.selectedSegmentIndex
            .asDriver()
            .drive { [weak self] _ in
                self?.pickerView.reloadAllComponents()
            }
            .disposed(by: disposeBag)
        
        let output = viewModel.transform(
            input: .init(
                outsideTapped: tapOutside.asObservable(),
                applyButtonTapped: applyButton.rx.tap.withUnretained(self).map { owner, _ in
                    switch self.segmentControl.selectedSegmentIndex {
                    case 0: return .all
                    case 1: return .year(owner.years[owner.pickerView.selectedRow(inComponent: 0)])
                    case 2:
                        let year = owner.pickerView.selectedRow(inComponent: 0)
                        let month = owner.pickerView.selectedRow(inComponent: 1)
                        if Locale.dateType == .mm_yyyy {
                            return .month(owner.years[month], owner.months[year])
                        } else {
                            return .month(owner.years[year], owner.months[month])
                        }
                    default: return .all
                    }
                }
                .asObservable()
            )
        )
        
        output.years
            .drive { [weak self] in self?.years = $0 }
            .disposed(by: disposeBag)
        
        output.months
            .drive { [weak self] in self?.months = $0 }
            .disposed(by: disposeBag)
        
        output.filter
            .drive(segmentControl.rx.selectedSegmentIndex)
            .disposed(by: disposeBag)
        
        Driver.combineLatest(
            segmentControl.rx.selectedSegmentIndex.asDriver(),
            output.selectedYearIdx,
            output.selectedMonthIdx
        )
        .drive { [weak self] idx, yearIdx, monthIdx in
            switch idx {
            case 0: break
            case 1:
                self?.pickerView.selectRow(yearIdx, inComponent: 0, animated: false)
            case 2:
                switch Locale.dateType {
                case .mm_yyyy:
                    self?.pickerView.selectRow(yearIdx, inComponent: 1, animated: false)
                    self?.pickerView.selectRow(monthIdx, inComponent: 0, animated: false)
                case .yyyy_mm:
                    self?.pickerView.selectRow(yearIdx, inComponent: 0, animated: false)
                    self?.pickerView.selectRow(monthIdx, inComponent: 1, animated: false)
                }
            default: break
            }
        }
        .disposed(by: disposeBag)
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if segmentControl.selectedSegmentIndex == 2 { return 2 }
        else { return 1 }
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return getNumberOfRows(forComponent: component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = configureLabel(from: view, for: pickerView, inComponent: component)
        
        label.text = getText(forRow: row, inComponent: component)
        label.textAlignment = getTextAlignment(forComponent: component)
        
        return label
    }
    
    @objc
    private func touchedOutside() {
        tapOutside.accept(())
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
                tapOutside.accept(())
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
            .left(self.view.pin.safeArea)
            .right(self.view.pin.safeArea)
            .height(45%)
        
        applyButton.flex
            .marginBottom(container.safeAreaInsets.bottom)
        
        container.flex.layout()
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.outsideView.alpha = 1
            
            container.pin
                .left(self.view.pin.safeArea)
                .right(self.view.pin.safeArea)
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
    
    deinit {
        print("Deinit: \(Self.self)")
    }
}


// MARK: - PickerView Label 설정
private extension HistoryFilterViewController {
    private func getLabelSpacing(forComponent component: Int)-> CGFloat {
        switch component {
        case 0:
            return Locale.dateType == .yyyy_mm ? -20 : -20
        case 1:
            return Locale.dateType == .yyyy_mm ? -20 : -20
        default: return 0
        }
    }
    private func getNumberOfRows(forComponent component: Int) -> Int {
        switch component {
        case 0:
            switch segmentControl.selectedSegmentIndex {
            case 0: return 1
            case 1: return years.count
            case 2:
                if Locale.dateType == .mm_yyyy { return months.count }
                else { return years.count }
            default: return 1
            }
        case 1:
            return Locale.dateType == .mm_yyyy ? years.count : months.count
        default:
            return 0
        }
    }
    
    private func configureLabel(from view: UIView?, for pickerView: UIPickerView, inComponent component: Int) -> UILabel {
        let label = (view as? UILabel) ?? UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .cursive(sizeOf: 26, weight: .medium)
        
        let componentSize = pickerView.rowSize(forComponent: component)
        
        label.frame = CGRect(x: 0, y: 0, width: componentSize.width + getLabelSpacing(forComponent: component), height: componentSize.height)
        
        return label
    }

    private func getText(forRow row: Int, inComponent component: Int) -> String {
        if component == 0 {
            if segmentControl.selectedSegmentIndex == 0 { return "All".localized }
            if segmentControl.selectedSegmentIndex == 2 && Locale.dateType == .mm_yyyy {
                return months[row].monthString
            }
            
            return years[row].yearString
        } else {
            return Locale.dateType == .mm_yyyy ? years[row].yearString : months[row].monthString
        }
    }

    private func getTextAlignment(forComponent component: Int) -> NSTextAlignment {
        if segmentControl.selectedSegmentIndex < 2 { return .center }
        
        if component == 0 {
            return Locale.direction == .leftToRight ? .right : .left
        }
        return Locale.direction == .leftToRight ? .left : .right
    }
}
