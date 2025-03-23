//
//  FetchPhotoDataUsecase.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import CoreStorageInterfaces

public protocol FetchPhotoDataUsecase {
    func execute(fileName: String)-> Single<FileInfo>
}
