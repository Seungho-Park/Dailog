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
import Photos

public struct GalleryViewModelAction {
    public let close: ([PHAsset])-> Void
    
    public init(close: @escaping ([PHAsset]) -> Void) {
        self.close = close
    }
}

public struct GalleryViewModelInput {
    public let viewDidLoad: Observable<Void>
    public let itemSelected: Observable<Int>
    public let cancelButtonTapped: Observable<Void>?
    
    public init(
        viewDidLoad: Observable<Void>,
        itemSelected: Observable<Int>,
        cancelButtonTapped: Observable<Void>?
    ) {
        self.viewDidLoad = viewDidLoad
        self.itemSelected = itemSelected
        self.cancelButtonTapped = cancelButtonTapped
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
    var actions: GalleryViewModelAction { get }
    
    var fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase { get }
    var fetchAssetImageDataUsecase: FetchAssetImageDataUsecase { get }
}
