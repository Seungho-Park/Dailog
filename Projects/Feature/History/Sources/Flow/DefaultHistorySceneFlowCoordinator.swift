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
        transition(scene: HistoryScene.filter(dependencies.makeHistoryFilterViewModel(actions: .init())), transitionStyle: .modal, animated: false)
        
//        let vc = HistoryFilterViewController<DefaultHistoryFilterViewModel>(viewModel: DefaultHistoryFilterViewModel())
//        vc.modalPresentationStyle = .overFullScreen
//        self.navigationController.visibleViewController?.present(vc, animated: false)
        
        return Observable.just(nil)
    }
}
