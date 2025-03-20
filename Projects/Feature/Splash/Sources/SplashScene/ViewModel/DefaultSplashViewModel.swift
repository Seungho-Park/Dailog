//
//  DefaultSplashViewModel.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import SharedUIInterfaces
import SharedUI
import AppTrackingTransparency
import AdAttributionKit
import FeatureSplashInterfaces
import UserNotifications

public final class DefaultSplashViewModel: SplashViewModel {
    public let disposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    public var action: SplashViewModelAction
    
    public init(action: SplashViewModelAction) {
        self.action = action
    }
    
    public func transform(input: FeatureSplashInterfaces.SplashViewModelInput) -> FeatureSplashInterfaces.SplashViewModelOutput {
        
        input.viewDidAppear
            .delay(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            .withUnretained(self)
            .concatMap { owner, _ in
                return owner.requestAppTrackingPermission()
            }
            .withUnretained(self)
            .concatMap { owner, _ in
                return owner.requestPushNotificationPermission()
            }
            .map { _ in
                //TODO: Login 여부 체크 -
            }
//            .subscribe { print($0) }
            .bind(onNext: action.showMainScene)
            .disposed(by: disposeBag)
        
        return .init()
    }
    
    public func requestPushNotificationPermission() -> Observable<Bool> {
        return Observable.create { observer in
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(granted)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }.observe(on: MainScheduler.asyncInstance)
    }
    
    public func requestAppTrackingPermission() -> Observable<String> {
        return Observable.create { observer in
            
            ATTrackingManager.requestTrackingAuthorization() { auth in
                if auth == .notDetermined { return }
                observer.onNext("")
                observer.onCompleted()
            }
            
            return Disposables.create()
        }.observe(on: MainScheduler.asyncInstance)
    }
}
