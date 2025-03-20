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

public protocol NavigationBar: UIView {
    var items: [NavigationBarButton] { get set }
    var title: String { get }
}

extension Reactive where Base: NavigationBar {
    var tap: ControlEvent<NavigationItem> {
        return ControlEvent(
            events: Observable.merge(
                base.items.map { item in
                    item.rx.tap.map { return item.type }.asObservable()
                }
            )
        )
    }
}
