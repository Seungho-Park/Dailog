//
//  FetchDiariesUsecase.swift
//  DomainDiary
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift

public protocol FetchDiariesUsecase {
    func execute(year: Int?, month: Int?, page: Int, count: Int)-> Single<[Diary]>
}
