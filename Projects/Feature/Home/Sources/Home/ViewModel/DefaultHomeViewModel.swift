//
//  DefaultHomeViewModel.swift
//  FeatureHome
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import FeatureHomeInterfaces


public final class DefaultHomeViewModel: HomeViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    
    public func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        return .init()
    }
}
