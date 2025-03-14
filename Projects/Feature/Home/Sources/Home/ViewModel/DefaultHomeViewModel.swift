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
import SharedUIInterfaces

public final class DefaultHomeViewModel: HomeViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let navigationBarStyle: NavigationBarStyle = .default(title: Date().formatted)
    
    public func transform(input: HomeViewModelInput) -> HomeViewModelOutput {
        return .init()
    }
}

private extension Date {
    var formatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd (EEE)"
        return formatter.string(from: self)
    }
}
