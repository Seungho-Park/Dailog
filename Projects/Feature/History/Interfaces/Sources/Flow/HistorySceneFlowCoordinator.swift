//
//  HistorySceneFlowCoordinator.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/12/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import RxSwift

public protocol HistorySceneFlowCoordinatorDependencies {
    func makeHistoryViewModel(actions: HistoryViewModelAction)-> any HistoryViewModel
}

public protocol HistorySceneFlowCoordinator: Coordinator {
    var dependencies: HistorySceneFlowCoordinatorDependencies { get }
    
    func showSelectFilterScene()-> Observable<HistoryFilterType?>
}
