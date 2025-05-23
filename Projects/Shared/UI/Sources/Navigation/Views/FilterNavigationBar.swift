//
//  FilterNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/21/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces

public final class FilterNavigationBar: NavigationBar {    
    private let container = UIView()
    private lazy var filterButton = NavigationBarSelectButton()
    
    public override var title: String {
        didSet {
            filterButton.text = title
            
            filterButton.flex.markDirty()
            filterButton.flex.layout()
            container.flex.layout()
        }
    }
    
    public convenience init(title: String) {
        self.init(items: [], title: title)
        self.title = title
        items.append(filterButton)
        configure()
    }
    
    public func configure() {
        self.addSubview(container)
        
        container.flex
            .direction(.row)
            .define { flex in
                flex.addItem(filterButton)
            }
            .justifyContent(Locale.direction == .leftToRight ? .start : .end)
            .alignItems(.center)
            .marginHorizontal(12)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
