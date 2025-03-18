//
//  DefaultWriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureWriteInterfaces
import RxSwift
import DomainWriteInterfaces
import PhotosUI

public final class DefaultWriteSceneFlowCoordinator: WriteSceneFlowCoordinator {
    public var dependencies: WriteSceneFlowCoordinatorDependencies
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: WriteSceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        transition(
            scene: DiaryWriteScene.write(
                dependencies.makeDiaryWriteViewModel(
                    emotion: nil,
                    actions: .init(
                        showSelectEmotion: {
                            return Observable<Emotion?>.create { [weak self] observer in
                                guard let self = self else {
                                    observer.onCompleted()
                                    return Disposables.create()
                                }
                                
                                self.showSelectEmotionScene { emotion in
                                    observer.onNext(emotion)
                                    observer.onCompleted()
                                }
                                
                                return Disposables.create()
                            }
                        },
                        showPhotoAlbum: showPhotoAlbumScene,
                        showDeviceCamera: showDeviceCamera
                    )
                )
            ),
            transitionStyle: .push,
            animated: true
        )
    }
    
    public func showSelectEmotionScene(completion: @escaping (Emotion?)-> Void) {
        transition(
            scene: DiaryWriteScene.emotion(
                dependencies.makeEmotionViewModel(
                    actions: .init(
                        selectEmotion: { [weak self] emotion in
                            completion(emotion)
                            self?.close(animated: true)
                        }
                    )
                )
            ),
            transitionStyle: .modal,
            animated: true
        )
    }
    
    public func showPhotoAlbumScene() {
//        var config = PHPickerConfiguration()
//        config.selectionLimit = 3
//        config.filter = .images
//        
//        let imagePicker = PHPickerViewController(configuration: config)
//        imagePicker.delegate = self
//        self.navigationController.topViewController?.present(imagePicker, animated: true, completion: nil)
        
        let viewModel = AlbumViewModel()
        let vc = AlbumViewController.create(viewModel: viewModel)
        
        self.navigationController.topViewController?.present(vc, animated: true, completion: nil)
    }
    
    public func showDeviceCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("카메라를 사용할 수 없습니다.")
            return
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
//        picker.delegate = self
        picker.allowsEditing = false

        self.navigationController.topViewController?.present(picker, animated: true, completion: nil)
    }
}

extension DefaultWriteSceneFlowCoordinator: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("result: \(results)")
    }
}
