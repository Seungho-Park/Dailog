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

public struct HomeViewModelAction {
    public let showWriteScene: ()-> Void
    
    public init(
        showWriteScene: @escaping () -> Void
    ) {
        self.showWriteScene = showWriteScene
    }
}

public struct HomeViewModelInput {
    public let viewWillAppear: Observable<Void>
    public let writeButtonTapped: Observable<Void>
    
    public init(
        viewWillAppear: Observable<Void>,
        writeButtonTapped: Observable<Void>
    ) {
        self.viewWillAppear = viewWillAppear
        self.writeButtonTapped = writeButtonTapped
    }
}

public struct HomeViewModelOutput {
    public let prompt: Driver<Prompts.Prompt.Translation>
    public let advice: Driver<AdviceList.Advice.Translation>
    
    public init(
        prompt: Driver<Prompts.Prompt.Translation>,
        advice: Driver<AdviceList.Advice.Translation>
    ) {
        self.prompt = prompt
        self.advice = advice
    }
}

public protocol HomeViewModel: ViewModel where Input == HomeViewModelInput, Output == HomeViewModelOutput {
    var actions: HomeViewModelAction { get }
    
    var fetchRandomPromptUsecase: FetchRandomPromptUsecase { get }
    var fetchRandomAdviceUsecase: FetchRandomAdviceUsecase { get }
}
