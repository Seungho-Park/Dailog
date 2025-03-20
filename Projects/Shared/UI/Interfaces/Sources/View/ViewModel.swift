//
//  ViewModel.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get }
    var background: BackgroundType { get }
    
    func transform(input: Input)-> Output
}

public extension ViewModel {
    var background: BackgroundType {
        return .clear
    }
}
