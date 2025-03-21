//
//  NavigationBarInterface.swift
//  SharedUI
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import UIKit

open class NavigationBar: UIView {
    public var items: [NavigationBarButton] = []
    public var title: String
    
    public init(items: [NavigationBarButton] = [], title: String) {
        self.items = items
        self.title = title
        
        super.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: NavigationBar {
    public var tap: ControlEvent<NavigationItem> {
        return ControlEvent(
            events: Observable.merge(
                base.items.map { item in
                    item.rx.tap.map { return item.type }.asObservable()
                }
            )
        )
    }
}
