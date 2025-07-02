//
//  DailogViewController.swift
//  SharedUI
//
//  Created by 박승호 on 6/27/25.
//

import UIKit

open class DailogViewController<VM: ViewModel>: UIViewController, ViewModelBindable {
    public var viewModel: VM!
    public let backgroundView = UIImageView(frame: .zero)
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\(self): \(#function)")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        backgroundView.image = .viewBackground
        
        configure()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("\(self): \(#function)")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("\(self): \(#function)")
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("\(self): \(#function)")
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("\(self): \(#function)")
    }
    
    open func bind() {
        print("\(self): \(#function)")
    }
    
    open func configure() {
        
    }
}
