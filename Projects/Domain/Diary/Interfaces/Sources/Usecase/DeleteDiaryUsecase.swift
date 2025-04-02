//
//  DeleteDiaryUsecase.swift
//  DomainDiary
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift

public protocol DeleteDiaryUsecase {
    func execute(diary: Diary)-> Single<Bool>
}
