//
//  AlbumItemCellViewModel.swift
//  SharedUI
//
//  Created by 박승호 on 3/19/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos

public struct AlbumItemCellViewModel {
    public let idx: Int
    public let photo: PHAsset
    public var selectedIdx: Int?
    
    init(idx: Int, photo: PHAsset, selectedIdx: Int? = nil) {
        self.idx = idx
        self.photo = photo
        self.selectedIdx = selectedIdx
    }
}
