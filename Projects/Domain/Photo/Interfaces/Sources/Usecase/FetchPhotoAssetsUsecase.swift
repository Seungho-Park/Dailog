//
//  FetchPhotoAssetsUsecase.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Photos
import RxSwift
import CorePhotoInterfaces

public protocol FetchPhotoAssetsUsecase {
    func execute(size: PhotoSize)-> Single<[PHAsset]>
}
