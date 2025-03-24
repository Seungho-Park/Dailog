//
//  DiaryWriteNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 3/24/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class DiaryWriteNavigationBar: NavigationBar {
    private let container = UIView()
    private let backButton: NavigationBackButton = .init()
    private let dateButton: NavigationBarSelectButton = .init()
    private let saveButton: NavigationBarButton = {
        let button = NavigationBarButton.init(type: .confirm)
        button.setImage(.check?.resize(size: .init(width: 24, height: 24)), for: .normal)
        button.flex.marginHorizontal(8)
        return button
    }()
    
    public override var title: String {
        didSet {
            dateButton.text = title
        }
    }
    
    public override init(items: [NavigationBarButton] = [], title: String) {
        super.init(items: items, title: title)
        self.items.append(backButton)
        self.items.append(dateButton)
        self.items.append(saveButton)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        dateButton.text = Date().formattedString()
        dateButton.font = .cursive(sizeOf: 18, weight: .medium)
        
        container
            .flex
            .addItem()
            .direction(.row)
            .grow(1)
            .define { flex in
                flex.addItem(Locale.direction == .leftToRight ? backButton : saveButton)
                flex.addItem().grow(1)
                flex.addItem(dateButton)
                flex.addItem().grow(1)
                flex.addItem(Locale.direction == .leftToRight ? saveButton : backButton)
            }
            .alignItems(.center)
            .justifyContent(.center)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError( "init(coder:) has not been implemented" )
    }
}
