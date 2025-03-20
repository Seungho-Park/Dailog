//
//  FetchAssetImageDataUsecase.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import Photos

public protocol FetchAssetImageDataUsecase {
    func execute(asset: PHAsset)-> Single<Data>
}
