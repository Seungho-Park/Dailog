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
    
    public lazy var navigationBar: NavigationBar = {
        let navBar = NavigationBar(frame: .zero)
        return navBar
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    open override func loadView() {
        let view = UIImageView(image: .bgLaunchScreen)
        view.contentMode = .scaleToFill
        self.view = view
    }
    
    open func configure() {
        view.addSubview(container)
        view.addSubview(navigationBar)
    }
    
    open func bind() {
        Observable.just(viewModel.isNavigationBarHidden)
            .asDriver(onErrorJustReturn: true)
            .drive(navigationBar.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    open override func viewDidLayoutSubviews() {
        navigationBar.pin
            .top(self.view.pin.safeArea.top)
            .left().right()
            .height(50)
        
        container.pin
            .below(of: navigationBar)
            .left().right().bottom()
        
        container.flex.layout()
        
        super.viewDidLayoutSubviews()
    }
}
