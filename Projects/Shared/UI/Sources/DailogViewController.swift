//
//  DailogViewController.swift
//  SharedUI
//
//  Created by 박승호 on 6/27/25.
//

import UIKit

open class DailogViewController<VM: ViewModel>: UIViewController, ViewModelBindable {
    public var viewModel: VM!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    open override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    public func bind() {
        
    }
}
