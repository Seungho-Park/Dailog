//
//  DefaultHistoryViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import SharedUIInterfaces
import FeatureHistoryInterfaces

public final class DefaultHistoryViewModel: HistoryViewModel {
    public let actions: HistoryViewModelAction
    public let disposeBag: DisposeBag = DisposeBag()
    
    public init(actions: HistoryViewModelAction) {
        self.actions = actions
    }
    
    public func transform(input: FeatureHistoryInterfaces.HistoryViewModelInput) -> FeatureHistoryInterfaces.HistoryViewModelOutput {
        
        input.filterButtonTapped?
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.actions.showSelectFilter()
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        return .init()
    }
}
