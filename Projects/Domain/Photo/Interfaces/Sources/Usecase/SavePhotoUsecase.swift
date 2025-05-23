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
import CoreStorageInterfaces

public protocol SavePhotoUsecase {
    func execute(data: Data?)-> Single<FileInfo>
    func execute(asset: PHAsset)-> Single<FileInfo>
}
