//
//  AlbumViewController.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

public final class AlbumViewController: DailogViewController<AlbumViewModel> {
    
    private var entries: [AlbumItemCellViewModel] = []
    private var selectedItems: BehaviorRelay<[AlbumItemCellViewModel]> = .init(value: [])
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(AlbumItemCell.self, forCellWithReuseIdentifier: AlbumItemCell.identifier)
        view.allowsSelection = true
        view.allowsMultipleSelection = true
        return view
    }()
    
    public override func configure() {
        super.configure()
        
        collectionView.delegate = self
        container.flex.addItem(collectionView)
            .grow(1)
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                viewWillAppear: rx.viewWillAppear.map { _ in }.asObservable(),
                selectedItems: selectedItems.asObservable()
            )
        )
        
        output.photos
            .drive { [weak self] photos in
                self?.entries = photos
            }
            .disposed(by: disposeBag)
        
        output.photos
            .drive(collectionView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withReuseIdentifier: AlbumItemCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? AlbumItemCell else { return cell }
                cell.fill(viewModel: item)
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}

extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3
        return .init(width: size - 0.5, height: size - 0.5)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.75
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.75
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var items = selectedItems.value
        guard let cell = collectionView.cellForItem(at: indexPath) as? AlbumItemCell else {
            return
        }
        items.append(entries[indexPath.row])
        cell.select(order: items.count)
        selectedItems.accept(items)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        var items = selectedItems.value
        guard let index = items.firstIndex(where: { item in
            item.idx == indexPath.row
        }) else {
            return
        }
        
        (collectionView.cellForItem(at: indexPath) as? AlbumItemCell)?.select(order: nil)
        items.remove(at: index)
        
        for i in 0..<items.count {
            items[i].selectedIdx = i + 1
            (collectionView.cellForItem(at: .init(row: items[i].idx, section: 0)) as? AlbumItemCell)?.select(order: i + 1)
        }
        
        selectedItems.accept(items)
    }
}
