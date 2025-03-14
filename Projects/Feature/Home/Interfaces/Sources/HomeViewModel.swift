//
//  HomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import SharedUIInterfaces
import DomainHomeInterfaces

public struct HomeViewModelInput {
    
    public init() {
    }
}

public struct HomeViewModelOutput {
    public let prompt: Driver<Prompts.Prompt.Translation>
    public init(prompt: Driver<Prompts.Prompt.Translation>) {
        self.prompt = prompt
    }
}

public protocol HomeViewModel: ViewModel where Input == HomeViewModelInput, Output == HomeViewModelOutput {
    var fetchRandomPromptUsecase: FetchRandomPromptUsecase { get }
}
