//
//  DefaultEmotionViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import SharedUI
import FeatureWriteInterfaces
import RxSwift
import RxCocoa

public final class DefaultEmotionViewModel: EmotionViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public var navigationBarStyle: NavigationBarStyle = .default(title: "")
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public func transform(input: EmotionViewModelInput) -> EmotionViewModelOutput {
        return .init()
    }
}
