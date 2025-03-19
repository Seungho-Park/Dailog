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
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("카메라를 사용할 수 없습니다.")
            return navigationController
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true

        self.navigationController.topViewController?.present(picker, animated: true, completion: nil)
//        let vc = GalleryViewController<DefaultGalleryViewModel>.create(viewModel: dependencies.makeGalleryViewModel() as! DefaultGalleryViewModel)
//        navigationController.topViewController?.present(vc, animated: true)
//        return vc
        return picker
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
