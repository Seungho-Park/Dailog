//
//  DeletePhotoFileUsecase.swift
//  DomainPhoto
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift

public protocol DeletePhotoFileUsecase {
    func execute(fileName: String)-> Single<Bool>
}
