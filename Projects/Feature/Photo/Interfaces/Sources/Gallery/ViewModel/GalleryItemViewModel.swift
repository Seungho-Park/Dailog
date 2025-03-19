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
    public let photo: Data?
    public var selectedIdx: Int?
    
    public init(idx: Int, photo: Data?, selectedIdx: Int? = nil) {
        self.idx = idx
        self.photo = photo
        self.selectedIdx = selectedIdx
    }
}
