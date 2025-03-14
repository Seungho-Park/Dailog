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
    
    public init(fetchRandomPromptUsecase: FetchRandomPromptUsecase) {
        self.fetchRandomPromptUsecase = fetchRandomPromptUsecase
    }
    
    public func transform(input: HomeViewModelInput) -> HomeViewModelOutput {        
        
        return .init(
            prompt: fetchRandomPromptUsecase.execute().asDriver(onErrorJustReturn: .init(title: "How was your day today?", subtitle: "Let’s record your feelings now."))
        )
    }
}
