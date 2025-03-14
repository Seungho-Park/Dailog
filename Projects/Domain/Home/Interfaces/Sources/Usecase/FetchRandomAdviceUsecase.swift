//
//  FetchRandomAdviceUsecase.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift

public protocol FetchRandomAdviceUsecase {
    func execute()-> Single<AdviceList.Advice.Translation>
}
