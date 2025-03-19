//
//  DefaultPhotoSceneDIContainer.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeaturePhotoInterfaces

public final class DefaultPhotoSceneDIContainer: PhotoSceneDIContainer {
    public func makeCoordinator(navController: UINavigationController) -> any Coordinator {
        return DefaultPhotoSceneFlowCoordinator(navigationController: navController, dependencies: self)
    }
    
    public func makeGalleryViewModel() -> any GalleryViewModel {
        return DefaultGalleryViewModel()
    }
}
