//
//  HistoryViewController.swift
//  FeatureCalendar
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import SharedUIInterfaces
import FeatureHistoryInterfaces
import RxSwift
import RxCocoa

public class HistoryViewController<VM: HistoryViewModel>: DailogViewController<VM> {
    
    private let emptyDataView = EmptyDataView(frame: .zero)
    
    public override func configure() {
        self.navigationBar = FilterNavigationBar(title: "전체")
        super.configure()
        
        container.flex
            .define { flex in
                flex.addItem(emptyDataView)
                    .position(.absolute)
                    .horizontally(0)
                    .vertically(0)
            }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                filterButtonTapped: navigationBar?.rx.tap.compactMap { $0 }.filter { $0 == .filter }.map { _ in }.asObservable()
            )
        )
    }
}
