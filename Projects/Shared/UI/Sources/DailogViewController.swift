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
    
    public var navigationBar: NavigationBar? = nil
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        printLogLifeCycle(#function)
        
        configure()
        bind()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        printLogLifeCycle(#function)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        printLogLifeCycle(#function)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        printLogLifeCycle(#function)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        printLogLifeCycle(#function)
    }
    
    open override func loadView() {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        self.view = view
    }
    
    open func configure() {
        self.view.backgroundColor = .clear
        
        if let navBar = navigationBar {
            view.addSubview(navBar)
        }
        view.addSubview(container)
    }
    
    open func bind() {
        switch viewModel.background {
        case .image(let image):
            (view as? UIImageView)?.image = image
        case .color(let color):
            view.backgroundColor = color
        case .clear:
            (view as? UIImageView)?.image = nil
            view.backgroundColor = .clear
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navBar = navigationBar {
            navBar.pin
                .top(view.pin.safeArea)
                .left(view.pin.safeArea)
                .right(view.pin.safeArea)
                .height(50)
            
            container.pin
                .below(of: navBar)
                .left(view.pin.safeArea)
                .right(view.pin.safeArea)
                .bottom(view.pin.safeArea)
        } else {
            container.pin.all(view.pin.safeArea)
        }
        
        container.flex.layout(mode: .fitContainer)
    }
    
    private func printLogLifeCycle(_ function: String) {
        #if DEBUG
        print("\(Self.self): \(function)")
        #endif
    }
}
