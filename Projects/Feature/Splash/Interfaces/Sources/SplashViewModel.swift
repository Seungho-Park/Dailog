//
//  SplashViewModel.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces
import RxSwift

public struct SplashViewModelAction {
    public let showMainScene: ()-> Void
    public let showLoginScene: ()-> Void
    
    public init(
        showMainScene: @escaping ()-> Void,
        showLoginScene: @escaping ()-> Void
    ) {
        self.showMainScene = showMainScene
        self.showLoginScene = showLoginScene
    }
}

public struct SplashViewModelInput {
    public let viewDidAppear: Observable<Void>
    
    public init(viewDidAppear: Observable<Void>) {
        self.viewDidAppear = viewDidAppear
    }
}

public struct SplashViewModelOutput {
    
    public init() {  }
}

public protocol SplashViewModel: ViewModel where Input == SplashViewModelInput, Output == SplashViewModelOutput {
    var action: SplashViewModelAction { get }
    
    func requestPushNotificationPermission()-> Observable<Bool>
    func requestAppTrackingPermission()-> Observable<String>
}
