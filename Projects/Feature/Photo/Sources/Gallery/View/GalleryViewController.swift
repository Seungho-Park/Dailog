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
        view.backgroundColor = .clear
        return view
    }()
    
    public override func configure() {
        self.navigationBar = ModalPickerNavigationBar(title: "Gallery".localized)
        super.configure()
        
        collectionView.delegate = self
        
        container.flex.addItem(collectionView)
            .marginTop(1)
            .grow(1)
    }
    
    public override func bind() {
        super.bind()
        
        let output = viewModel.transform(
            input: .init(
                viewDidLoad: rx.viewDidLoad.asObservable(),
                itemSelected: collectionView.rx.modelSelected(GalleryItemViewModel.self).map { $0.idx }.asObservable(),
                cancelButtonTapped: navigationBar?.rx.tap.filter { $0 == .back }.map { _ in }.asObservable(),
                selectButtonTapped: navigationBar?.rx.tap.filter { $0 == .confirm }.map { _ in }.asObservable()
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
        
        output.selectedCount
            .drive { [weak self] count in
                guard let self else { return }
                (self.navigationBar as? ModalPickerNavigationBar)?.canSelect = count > 0
            }
            .disposed(by: disposeBag)
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
