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
import CoreStorageInterfaces

public struct GalleryViewModelAction {
    public let close: ([FileInfo])-> Void
    
    public init(close: @escaping ([FileInfo]) -> Void) {
        self.close = close
    }
}

public struct GalleryViewModelInput {
    public let viewDidLoad: Observable<Void>
    public let itemSelected: Observable<Int>
    public let cancelButtonTapped: Observable<Void>?
    public let selectButtonTapped: Observable<Void>?
    
    public init(
        viewDidLoad: Observable<Void>,
        itemSelected: Observable<Int>,
        cancelButtonTapped: Observable<Void>?,
        selectButtonTapped: Observable<Void>?
    ) {
        self.viewDidLoad = viewDidLoad
        self.itemSelected = itemSelected
        self.cancelButtonTapped = cancelButtonTapped
        self.selectButtonTapped = selectButtonTapped
    }
}

public struct GalleryViewModelOutput {
    public let cellItems: Driver<[GalleryItemViewModel]>
    public let selectedCount: Driver<Int>
    public init(
        cellItems: Driver<[GalleryItemViewModel]>,
        selectedCount: Driver<Int>
    ) {
        self.cellItems = cellItems
        self.selectedCount = selectedCount
    }
}

public protocol GalleryViewModel: ViewModel where Input == GalleryViewModelInput, Output == GalleryViewModelOutput {
    var actions: GalleryViewModelAction { get }
    
    var fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase { get }
    var fetchAssetImageDataUsecase: FetchAssetImageDataUsecase { get }
    var savePhotoUsecaes: SavePhotoUsecase { get }
}
