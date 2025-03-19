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
    
    public init(
        viewWillAppear: Observable<Void>
    ) {
        self.viewWillAppear = viewWillAppear
    }
}

public struct GalleryViewModelOutput {
    
    public init() {  }
}

public protocol GalleryViewModel: ViewModel where Input == GalleryViewModelInput, Output == GalleryViewModelOutput {
    
}
