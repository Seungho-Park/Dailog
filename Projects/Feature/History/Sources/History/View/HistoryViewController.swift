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
    
    private let writeButton: UIButton = {
        let btn = UIButton(frame: .zero)
        var config = UIButton.Configuration.filled()
        btn.configuration = config
        btn.layer.masksToBounds = true
        btn.configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(
                "+",
                attributes: .init(
                    [
                        NSAttributedString.Key.foregroundColor : btn.state != .highlighted ? UIColor.btnTextColor : UIColor.btnTextColor.withAlphaComponent(0.6),
                        NSAttributedString.Key.font: UIFont.cursive(sizeOf: 36, weight: .medium)
                    ]
                )
            )
            btn.configuration?.baseBackgroundColor = btn.state == .highlighted ? .softCoralHighlight : .softCoral
        }
        return btn
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
        
        container
            .flex
            .define { flex in
                let item = flex.addItem(writeButton)
                    .position(.absolute)
                    .width(48)
                    .height(48)
                    .cornerRadius(24)
                    .bottom(12)
                
                if Locale.direction == .leftToRight {
                    item.right(12)
                } else {
                    item.left(12)
                }
            }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                viewWillAppear: rx.viewWillAppear.map { _ in }.asObservable(),
                filterButtonTapped: navigationBar?.rx.tap.compactMap { $0 }.filter { $0 == .filter }.map { _ in }.asObservable(),
                willDisplayCell: tableView.rx.willDisplayCell.map { $0.indexPath.row }.asObservable(),
                writeDiaryButtonTapped: writeButton.rx.tap.asObservable()
            )
        )
        
        output.items
            .drive { [weak self] items in
                self?.tableView.isHidden = items.isEmpty
                self?.emptyDataView.isHidden = !items.isEmpty
            }
            .disposed(by: disposeBag)
        
        
        output.items
            .drive(tableView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withIdentifier: DiaryListItemCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? DiaryListItemCell else { return cell }
                cell.fill(viewModel: item)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.filter
            .drive(((navigationBar as? FilterNavigationBar)?.rx.title)!)
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
