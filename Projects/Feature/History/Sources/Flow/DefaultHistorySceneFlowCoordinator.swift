//
//  DefaultHistorySceneFlowCoordinator.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureHistoryInterfaces
import SharedUI
import RxSwift
import RxCocoa

public final class DefaultHistorySceneFlowCoordinator: HistorySceneFlowCoordinator {
    public var dependencies: any HistorySceneFlowCoordinatorDependencies
    
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: any HistorySceneFlowCoordinatorDependencies) {
        self.dependencies = dependencies
        self.navigationController = navigationController
    }
    
    @discardableResult
    public func start() -> UIViewController {
        return HistoryScene.history(
            dependencies.makeHistoryViewModel(
                actions: .init(
                    showSelectFilter: showSelectFilterScene
                )
            )
        ).instantiate()
    }
    
    public func showSelectFilterScene() -> Observable<HistoryFilterType?> {
        return Observable<HistoryFilterType?>.create { [weak self] observer in
            guard let self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            transition(
                scene: HistoryScene.filter(
                    dependencies.makeHistoryFilterViewModel(
                        actions: .init(
                            selectFilter: { [weak self] type in
                                self?.close(animated: false) {
                                    observer.onNext(type)
                                    observer.onCompleted()
                                }
                            }
                        )
                    )
                ),
                transitionStyle: .modal,
                animated: false
            )
            
            return Disposables.create()
        }
    }
}
