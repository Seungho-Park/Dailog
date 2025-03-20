//
//  GalleryItemViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos

public struct GalleryItemViewModel {
    public let idx: Int
    public let asset: PHAsset
    public var selectedIdx: Int?
    
    public let image: (PHAsset, @escaping (Data?)-> Void)-> Void
    
    public init(idx: Int, asset: PHAsset, selectedIdx: Int? = nil, image: @escaping (PHAsset, @escaping (Data?)-> Void)-> Void) {
        self.idx = idx
        self.asset = asset
//        self.imageData = imageData
        self.selectedIdx = selectedIdx
        self.image = image
    }
}
