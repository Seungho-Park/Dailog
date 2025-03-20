//
//  HomeNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public final class HomeNavigationBar: NavigationBar {
    private var timer: Timer?
    
    private let container = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.text = title
        label.font = .serif(sizeOf: 20, weight: .medium).italic
        label.textColor = .navigationTitle
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.font = .cursive(sizeOf: 18, weight: .medium)
        label.textColor = .textColor
        label.text = Date().formattedString()
        label.numberOfLines = 1
        return label
    }()
    
    private let backButton = NavigationBackButton()
    
    public convenience init() {
        self.init(items: [], title: "")
        items.append(backButton)
        configure()
        setupTimer()
    }
    
    private func configure() {
        addSubview(container)
        
        container.flex
            .addItem()
            .grow(1)
            .direction(.row)
            .define { flex in
                if Locale.direction == .leftToRight {
                    flex.addItem(titleLabel)
                    flex.addItem().grow(1)
                    flex.addItem(dateLabel)
                } else {
                    flex.addItem(dateLabel)
                    flex.addItem().grow(1)
                    flex.addItem(titleLabel)
                }
            }
            .justifyContent(.center)
            .marginHorizontal(12)
    }
    
    private func setupTimer() {
        invalidTimer()
        
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            dateLabel.text = Date().formattedString()
            dateLabel.flex.markDirty()
            container.flex.layout()
        })
        
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    private func invalidTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        invalidTimer()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
