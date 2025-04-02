//
//  DiaryNavigationBar.swift
//  SharedUI
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit

public final class DiaryNavigationBar: NavigationBar {
    private let container = UIView()
    private let backButton: NavigationBackButton = .init()
    private let titleLabel: UILabel = {
        let label = UILabel.make(frame: .zero)
        label.numberOfLines = 1
        label.text = "DAILOG"
        label.font = .serif(sizeOf: 20, weight: .medium).italic
        label.textColor = .navigationTitle
        return label
    }()
    private let moreButton: NavigationBarButton = {
        let button = NavigationBarButton.init(type: .more)
        button.setImage(.more?.resize(size: .init(width: 24, height: 24)), for: .normal)
        button.flex.marginHorizontal(8)
        return button
    }()
    
    public override var title: String {
        didSet {
            titleLabel.text = title
        }
    }
    
    public override init(items: [NavigationBarButton] = [], title: String) {
        super.init(items: items, title: title)
        self.items.append(backButton)
        self.items.append(moreButton)
        
        configure()
    }
    
    private func configure() {
        addSubview(container)
        
        container
            .flex
            .addItem()
            .direction(.row)
            .grow(1)
            .define { flex in
                flex.addItem(Locale.direction == .leftToRight ? backButton : moreButton)
                flex.addItem().grow(1)
                flex.addItem(titleLabel)
                flex.addItem().grow(1)
                flex.addItem(Locale.direction == .leftToRight ? moreButton : backButton)
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
