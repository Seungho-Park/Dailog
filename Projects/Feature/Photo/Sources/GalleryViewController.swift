//
//  GalleryViewController.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeaturePhotoInterfaces
import SharedUI
import PinLayout
import FlexLayout
import RxSwift
import RxCocoa

public final class GalleryViewController<VM: GalleryViewModel>: DailogViewController<VM>, UICollectionViewDelegateFlowLayout {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.register(GalleryItemViewCell.self, forCellWithReuseIdentifier: GalleryItemViewCell.identifier)
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
                itemSelected: collectionView.rx.modelSelected(GalleryItemViewModel.self).map { $0.idx }.asObservable()
            )
        )
        
        output.cellItems
            .drive(collectionView.rx.items) { view, row, item in
                let cell = view.dequeueReusableCell(withReuseIdentifier: GalleryItemViewCell.identifier, for: .init(row: row, section: 0))
                guard let cell = cell as? GalleryItemViewCell else { return cell }
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
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / 3 - 0.5
        return .init(width: size, height: size)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
}
