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
    
    private var navigationBar: NavigationBar?
    public let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        bind()
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
    
    open override func loadView() {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.layer.masksToBounds = true
        self.view = view
    }
    
    open func configure() {
        self.view.backgroundColor = .clear
        
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
        
        switch viewModel.navigationBarStyle {
        case .none:
            self.navigationBar?.removeFromSuperview()
            self.navigationBar = nil
        case .default(let title):
            self.navigationBar = DefaultNavigationBar(frame: .zero)
            self.navigationBar?.title = title
            
            let isRoot = (self.navigationController?.viewControllers.count ?? 0) <= 1
            (self.navigationBar as! DefaultNavigationBar)
                .backButton
                .flex
                .isIncludedInLayout(!isRoot)
        case .filter:
            self.navigationBar = FilterNavigationBar(title: "전체")
        }
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = navigationBar {
            view.addSubview(navigationBar)
            navigationBar.pin
                .top(view.pin.safeArea)
                .left(view.pin.safeArea)
                .right(view.pin.safeArea)
                .height(50)
            
            container.pin
                .below(of: navigationBar)
                .left(view.pin.safeArea)
                .right(view.pin.safeArea)
                .bottom(view.pin.safeArea)
        } else {
            container.pin.all(view.pin.safeArea)
        }
        
        container.flex.layout(mode: .fitContainer)
    }
}
