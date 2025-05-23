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
import Photos
import UIKit
import CoreStorageInterfaces

public final class DefaultPhotoSceneFlowCoordinator: NSObject, PhotoSceneFlowCoordinator {
    private var picker: UIImagePickerController?
    private let scene: PhotoScene
    private let completion: (([FileInfo])-> Void)?
    public let navigationController: UINavigationController
    public let dependencies: any PhotoSceneFlowCoordinatorDependencies
    
    public init(
        scene: PhotoScene,
        navigationController: UINavigationController,
        dependencies: any PhotoSceneFlowCoordinatorDependencies,
        completion: (([FileInfo])-> Void)?
    ) {
        self.scene = scene
        self.completion = completion
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        switch scene {
        case .gallery:
            let vm = dependencies.makeGalleryViewModel(
                actions: .init(
                    close: closeAction(files:)
                )
            ) as! DefaultGalleryViewModel
            let vc = GalleryViewController<DefaultGalleryViewModel>.create(viewModel: vm)
            vc.view.backgroundColor = .white
            vc.modalPresentationStyle = .automatic
            navigationController.visibleViewController?.present(vc, animated: true)
            return vc
        case .camera:
            let vm = dependencies.makeCameraViewModel(
                actions: .init(
                    close: closeCamera(file:)
                )
            )
            let vc = CameraViewController.create(viewModel: vm as! DefaultCameraViewModel)
            vc.modalPresentationStyle = .fullScreen
            navigationController.visibleViewController?.present(vc, animated: true, completion: nil)
            return vc
        }
    }
    
    private func closeCamera(file: FileInfo?) {
        if let file = file {
            completion?([file])
        }
        close(animated: true)
    }
    
    private func closeAction(files: [FileInfo]) {
        completion?(files)
        close(animated: true)
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
}
