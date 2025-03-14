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
    
    public var navigationBar: NavigationBar?
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
        self.view = view
    }
    
    open func configure() {
        self.view.backgroundColor = .clear
        
        view.addSubview(container)
    }
    
    open func bind() {
        Observable
            .just(viewModel.background)
            .asDriver(onErrorJustReturn: .clear)
            .drive { [weak self] type in
                (self?.view as? UIImageView)?.image = nil
                self?.view.backgroundColor = .clear
                switch type {
                case .image(let image):
                    (self?.view as? UIImageView)?.image = image
                case .color(let color):
                    self?.view.backgroundColor = UIColor(named: color, in: .module, compatibleWith: nil)
                default: break
                }
            }
            .disposed(by: disposeBag)
        
        Observable.just(viewModel.navigationBarStyle)
            .asDriver(onErrorJustReturn: .none)
            .drive { [weak self] style in
                guard let self = self else { return }
                switch style {
                case .none:
                    self.navigationBar?.removeFromSuperview()
                    self.navigationBar = nil
                case .default(let title):
                    self.navigationBar = DefaultNavigationBar(frame: .zero)
                    self.navigationBar?.title = title
                    self.view.addSubview(self.navigationBar!)
                    let isRoot = (self.navigationController?.viewControllers.count ?? 0) <= 1
                    (self.navigationBar as! DefaultNavigationBar)
                        .backButton
                        .flex
                        .isIncludedInLayout(!isRoot)
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navigationBar = navigationBar {            
            container.pin
                .below(of: navigationBar)
                .left()
                .right()
                .bottom()
        } else {
            container.pin.all()
        }
        
        container.flex.layout()
    }
}
