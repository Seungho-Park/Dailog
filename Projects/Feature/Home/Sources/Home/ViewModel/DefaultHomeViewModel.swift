//
//  DefaultHomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import FeatureHomeInterfaces
import DomainHomeInterfaces
import SharedUIInterfaces
import SharedUI

public final class DefaultHomeViewModel: HomeViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let navigationBarStyle: NavigationBarStyle = .default(title: Date().formattedString())
    
    public let fetchRandomPromptUsecase: FetchRandomPromptUsecase
    public let fetchRandomAdviceUsecase: FetchRandomAdviceUsecase
    
    public init(
        fetchRandomPromptUsecase: FetchRandomPromptUsecase,
        fetchRandomAdviceUsecase: FetchRandomAdviceUsecase
    ) {
        self.fetchRandomPromptUsecase = fetchRandomPromptUsecase
        self.fetchRandomAdviceUsecase = fetchRandomAdviceUsecase
    }
    
    public func transform(input: HomeViewModelInput) -> HomeViewModelOutput {        
        let prompt: BehaviorRelay<Prompts.Prompt.Translation> = .init(value: .init(title: "", subtitle: ""))
        let advice: BehaviorRelay<AdviceList.Advice.Translation> = .init(value: .init(text: "", author: .init(name: "", description: "")))
        
        let viewDidAppear = input.viewWillAppear
            .share()
        
        viewDidAppear
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.fetchRandomPromptUsecase.execute()
                    .catchAndReturn(.init(title: "How was your day today?", subtitle: "Let’s record your feelings now."))
            }
            .bind(to: prompt)
            .disposed(by: disposeBag)
        
        viewDidAppear
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.fetchRandomAdviceUsecase.execute()
                    .catchAndReturn(.init(text: "Don't be afraid of failure. Enjoy the challenge.", author: .init(name: "Richard Branson", description: "Founder of Virgin Group, entrepreneur")))
            }
            .bind(to: advice)
            .disposed(by: disposeBag)
        
        
        return .init(
            prompt: prompt.asDriver(),
            advice: advice.asDriver()
        )
    }
}
