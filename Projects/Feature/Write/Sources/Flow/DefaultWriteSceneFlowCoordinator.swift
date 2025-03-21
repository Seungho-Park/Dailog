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

public final class DefaultWriteSceneFlowCoordinator: NSObject, WriteSceneFlowCoordinator, UINavigationControllerDelegate {
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
                        close: { [weak self] in self?.navigationController.popViewController(animated: true) },
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
        let coordinator = dependencies.makePhotoSceneFlowCoordinator(scene: .gallery, navigationController: navigationController) { assets in
            print("Gallery: \(assets)")
        }
        coordinator.start()
    }
    
    public func showDeviceCamera() {
        let coordinator = dependencies.makePhotoSceneFlowCoordinator(scene: .camera, navigationController: navigationController) { assets in
            print("Camera: \(assets)")
        }
        coordinator.start()
    }
}

extension DefaultWriteSceneFlowCoordinator: PHPickerViewControllerDelegate, UIImagePickerControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print("result: \(results)")
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
    }
}
