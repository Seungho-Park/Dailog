//
//  SavePhotoUsecase.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import Photos

public protocol SavePhotoUsecase {
    func execute(data: Data?)-> Single<String>
    func execute(asset: PHAsset)-> Single<String>
}
