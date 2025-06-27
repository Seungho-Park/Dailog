//
//  ViewModelBindable.swift
//  SharedUI
//
//  Created by 박승호 on 6/27/25.
//

import UIKit

public protocol ViewModelBindable: NSObjectProtocol {
    associatedtype ViewModelType: ViewModel
    
    var viewModel: ViewModelType! { get set }
    
    func bind()
}

public extension ViewModelBindable where Self: UIViewController {
    private func bindViewModel(viewModel: ViewModelType) {
        self.viewModel = viewModel
        self.loadViewIfNeeded()
        
        bind()
    }
    
    static func create(viewModel: ViewModelType)-> Self {
        let vc = Self.init()
        vc.bindViewModel(viewModel: viewModel)
        return vc
    }
}
