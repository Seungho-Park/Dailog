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
import DomainPhotoInterfaces

public struct GalleryViewModelInput {
    public let viewDidLoad: Observable<Void>
    public let itemSelected: Observable<Int>
    
    public init(
        viewDidLoad: Observable<Void>,
        itemSelected: Observable<Int>
    ) {
        self.viewDidLoad = viewDidLoad
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
    
    var fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase { get }
    var fetchAssetImageDataUsecase: FetchAssetImageDataUsecase { get }
}
