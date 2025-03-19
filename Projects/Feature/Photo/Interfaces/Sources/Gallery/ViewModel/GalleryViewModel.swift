//
//  PhotoViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift
import RxCocoa

public struct GalleryViewModelInput {
    public let viewWillAppear: Observable<Void>
    public let itemSelected: Observable<Int>
    
    public init(
        viewWillAppear: Observable<Void>,
        itemSelected: Observable<Int>
    ) {
        self.viewWillAppear = viewWillAppear
        self.itemSelected = itemSelected
    }
}

public struct GalleryViewModelOutput {
    public let cellItems: Driver<[GalleryItemViewModel]>
    public init(
        cellItems: Driver<[GalleryItemViewModel]>
    ) {
        self.cellItems = cellItems
    }
}

public protocol GalleryViewModel: ViewModel where Input == GalleryViewModelInput, Output == GalleryViewModelOutput {
    
}
