//
//  DailogViewController.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import RxSwift
import PinLayout
import FlexLayout

open class DailogViewController<VM: ViewModel>: UIViewController, ViewModelBinable {
    public var viewModel: VM!
    public let container = DailogView(frame: .zero)
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func loadView() {
        self.view = container
    }
    
    open func configure() {
        
    }
    
    open func bind() {
        
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        container.pin.all()
        container.flex.layout()
    }
}
