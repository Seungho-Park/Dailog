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
import RxCocoa
import PinLayout
import FlexLayout

open class DailogViewController<VM: ViewModel>: UIViewController, ViewModelBinable {
    public var viewModel: VM!
    public let container = DailogView(frame: .zero)
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            print("\(Self.self): \(#function)")
        #endif
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        #if DEBUG
            print("\(Self.self): \(#function)")
        #endif
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        #if DEBUG
            print("\(Self.self): \(#function)")
        #endif
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        #if DEBUG
            print("\(Self.self): \(#function)")
        #endif
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        #if DEBUG
            print("\(Self.self): \(#function)")
        #endif
    }
    
    open func configure() {
        self.view.backgroundColor = .clear
        
        view.addSubview(container)
    }
    
    open func bind() {
        
    }
    
    open override func viewDidLayoutSubviews() {
        container.pin.all()
        container.flex.layout()
        
        super.viewDidLayoutSubviews()
    }
}
