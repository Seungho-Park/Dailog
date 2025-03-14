//
//  FetchRandomPromptUsecase.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift

public protocol FetchRandomPromptUsecase {
    func execute()-> Single<Prompts.Prompt.Translation>
}
