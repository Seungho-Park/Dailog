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
    public let imageData: Data?
    public var selectedIdx: Int?
    
    public init(idx: Int, asset: PHAsset, imageData: Data?, selectedIdx: Int? = nil) {
        self.idx = idx
        self.asset = asset
        self.imageData = imageData
        self.selectedIdx = selectedIdx
    }
}
