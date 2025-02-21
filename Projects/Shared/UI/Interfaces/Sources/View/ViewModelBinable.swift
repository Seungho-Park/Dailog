//
//  ViewModelBinable.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import UIKit

public protocol ViewModelBinable: NSObjectProtocol {
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType! { get set }
    
    func configure()
    func bind()
}

public extension ViewModelBinable where Self: UIViewController {
    static func create(viewModel: ViewModelType)-> Self {
        let vc = Self.init()
        vc.bindViewModel(viewModel: viewModel)
        return vc
    }
    
    private func bindViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
        self.loadViewIfNeeded()
        
        configure()
        bind()
    }
}
