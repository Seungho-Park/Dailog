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

public final class GalleryViewController<VM: GalleryViewModel>: DailogViewController<VM> {
    
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
        container.flex.addItem(collectionView)
            .grow(1)
    }
    
    public override func bind() {
        super.bind()
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        container.pin.all()
        container.flex.layout()
    }
}
