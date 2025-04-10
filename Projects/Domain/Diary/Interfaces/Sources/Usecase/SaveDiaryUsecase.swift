//
//  SaveDiaryUsecase.swift
//  DomainWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift

public protocol SaveDiaryUsecase {
    func execute(
        diary: NewDiary
    )-> Single<NewDiary>
}
