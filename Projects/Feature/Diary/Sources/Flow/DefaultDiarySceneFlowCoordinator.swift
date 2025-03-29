//
//  DefaultWriteSceneFlowCoordinator.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUI
import FeatureDiaryInterfaces
import RxSwift
import DomainDiaryInterfaces
import PhotosUI
import CoreStorageInterfaces

public final class DefaultDiarySceneFlowCoordinator: NSObject, DiarySceneFlowCoordinator {
    public var dependencies: DiarySceneFlowCoordinatorDependencies
    public var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController, dependencies: DiarySceneFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        transition(
            scene: DiaryWriteScene.write(
                dependencies.makeDiaryWriteViewModel(
                    diary: nil,
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
                        showDeviceCamera: showDeviceCamera,
                        showDatePicker: showDatePicker(date:)
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
    
    public func showPhotoAlbumScene()-> Observable<[FileInfo]> {
        return .create { [weak self] observer in
            guard let self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let coordinator = self.dependencies.makePhotoSceneFlowCoordinator(scene: .gallery, navigationController: navigationController) { fileNameList in
                observer.onNext(fileNameList)
                observer.onCompleted()
            }
            
            coordinator.start()
            return Disposables.create()
        }
    }
    
    public func showDeviceCamera()-> Observable<[FileInfo]> {
        return .create { [weak self] observer in
            guard let self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            let coordinator = self.dependencies.makePhotoSceneFlowCoordinator(scene: .camera, navigationController: navigationController) { fileNameList in
                observer.onNext(fileNameList)
                observer.onCompleted()
            }
            
            coordinator.start()
            return Disposables.create()
        }
    }
    
    public func showDatePicker(date: Date) -> Observable<Date?> {
        return Observable<Date?>.create { [weak self] observer in
            guard let self else {
                observer.onCompleted()
                return Disposables.create()
            }
            
            self.transition(
                scene: DiaryWriteScene.datePicker(
                    dependencies.makeDatePickerViewModel(
                        date: date,
                        actions: .init(close: { [weak self] date in
                            observer.onNext(date)
                            observer.onCompleted()
                            self?.close(animated: false)
                        })
                    )
                ),
                transitionStyle: .modal,
                animated: false
            )
            
            return Disposables.create()
        }
    }
}
