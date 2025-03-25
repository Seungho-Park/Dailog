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
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(DiaryListItemCell.self, forCellReuseIdentifier: DiaryListItemCell.identifier)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 150
        table.clipsToBounds = true
        return table
    }()
    
    public override func configure() {
        self.navigationBar = FilterNavigationBar(title: "전체")
        super.configure()
        
        container.flex
            .define { flex in
                flex.addItem(emptyDataView)
                    .position(.absolute)
                    .horizontally(0)
                    .vertically(0)
                
                flex.addItem(tableView)
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
                filterButtonTapped: navigationBar?.rx.tap.compactMap { $0 }.filter { $0 == .filter }.map { _ in }.asObservable(),
                willDisplayCell: tableView.rx.willDisplayCell.map { $0.indexPath.row }.asObservable()
            )
        )
        
        let items = Observable<[Int]>.just([1,2,3,4])
            .asDriver(onErrorJustReturn: [])
        
        items
            .drive { [weak self] items in
                self?.tableView.isHidden = items.isEmpty
                self?.emptyDataView.isHidden = !items.isEmpty
            }
            .disposed(by: disposeBag)
        
        
        items
            .filter { !$0.isEmpty }
            .drive(tableView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withIdentifier: DiaryListItemCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? DiaryListItemCell else { return cell }
                
                return cell
            }
            .disposed(by: disposeBag)
    }
}
