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

public final class DefaultPhotoSceneFlowCoordinator: NSObject, PhotoSceneFlowCoordinator {
    private let scene: PhotoScene
    private let completion: (([PHAsset])-> Void)?
    public let navigationController: UINavigationController
    public let dependencies: any PhotoSceneFlowCoordinatorDependencies
    
    public init(
        scene: PhotoScene,
        navigationController: UINavigationController,
        dependencies: any PhotoSceneFlowCoordinatorDependencies,
        completion: @escaping ([PHAsset])-> Void
    ) {
        self.scene = scene
        self.completion = completion
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        switch scene {
        case .gallery:
            let vm = dependencies.makeGalleryViewModel() as! DefaultGalleryViewModel
            let vc = GalleryViewController<DefaultGalleryViewModel>.create(viewModel: vm)
            navigationController.topViewController?.present(vc, animated: true)
            return vc
        case .camera:
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = false
            picker.cameraCaptureMode = .photo
            
            self.navigationController.topViewController?.present(picker, animated: true, completion: nil)
            return picker
        }
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
}

extension DefaultPhotoSceneFlowCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            print("사진 찍힘")
        } else if let image = info[.originalImage] as? UIImage {
            // 편집되지 않은 원본 이미지 처리
            print("원본 이미지: \(image)")
        }
    }
    
}
