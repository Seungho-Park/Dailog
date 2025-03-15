//
//  HistoryFilterViewController.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/16/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import PinLayout
import FlexLayout
import SharedUI
import FeatureHistoryInterfaces

public final class HistoryFilterViewController<VM: HistoryFilterViewModel>: DailogViewController<VM> {
    private let outsideView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .component(0, 0, 0, 0.6)
        return view
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
        
    }
    
    public override func bind() {
        super.bind()
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
    
    public override func viewDidLayoutSubviews() {
        outsideView.pin
            .bottom()
            .left().right().top()
        
        container.pin
            .below(of: self.view)
            .left()
            .right()
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.outsideView.alpha = 1
            
            outsideView.pin
                .above(of: container)
                .left().right().top()
            
            container.pin
                .left().right()
                .bottom()
                .height(45%)
            
        } completion: { [weak self] _ in
            self?.container.flex.layout()
        }
    }
    
    @objc
    private func touchedOutside() {
        dismiss(animated: false)
    }
    
    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view!)
        let velocity = gesture.velocity(in: gesture.view!) // 속도 측정

        switch gesture.state {
        case .changed:
            if translation.y > 0 {
                container.frame.origin.y = view.frame.height - container.frame.height + translation.y
            }
        case .ended:
            if velocity.y > 1000 {
                dismiss(animated: false, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2) { [weak self] in
                    self?.container.frame.origin.y = (self?.view.frame.height ?? 0) - (self?.container.frame.height ?? 0)
                }
            }
        default: break
        }
    }
}
