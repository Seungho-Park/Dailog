//
//  DefaultPhotoSceneFlowCoordinator.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import SharedUI
import SharedUIInterfaces
import FeaturePhotoInterfaces
import UIKit

public final class DefaultPhotoSceneFlowCoordinator: NSObject, PhotoSceneFlowCoordinator {
    public let navigationController: UINavigationController
    public let dependencies: any PhotoSceneFlowCoordinatorDependencies
    
    public init(navigationController: UINavigationController, dependencies: any PhotoSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        let vc = GalleryViewController<DefaultGalleryViewModel>.create(viewModel: dependencies.makeGalleryViewModel() as! DefaultGalleryViewModel)
        navigationController.topViewController?.present(vc, animated: true)
        return vc
    }
}

extension DefaultPhotoSceneFlowCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
