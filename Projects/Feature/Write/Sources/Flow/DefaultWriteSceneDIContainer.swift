//
//  DefaultWriteSceneDIContainer.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import FeatureWriteInterfaces
import SharedUIInterfaces
import DomainWriteInterfaces

public final class DefaultWriteSceneDIContainer: WriteSceneDIContainer {
    
    public init() {  }
    
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultWriteSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
    
    public func makeDiaryWriteViewModel(emotion: Emotion?, actions: DiaryWriteViewModelAction) -> any DiaryWriteViewModel {
        return DefaultDiaryWriteViewModel(emotion: emotion, actions: actions)
    }
    
    public func makeEmotionViewModel(actions: EmotionViewModelActions) -> any EmotionViewModel {
        return DefaultEmotionViewModel(actions: actions)
    }
}
