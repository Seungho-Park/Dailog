//
//  DefaultMainViewModel.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import FeatureMainInterfaces
import SharedUIInterfaces
import SharedUI
import RxSwift

public final class DefaultMainViewModel: MainViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public func transform(input: MainViewModelInput) -> MainViewModelOutput {
        return .init()
    }
}
