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
    
    var isNavigationBarHidden: Bool { get }
    var disposeBag: DisposeBag { get }
    
    func transform(input: Input)-> Output
}
