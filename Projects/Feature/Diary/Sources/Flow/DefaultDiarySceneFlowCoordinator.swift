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
    public var diary: NewDiary?
    public var dependencies: DiarySceneFlowCoordinatorDependencies
    public var navigationController: UINavigationController
    
    public init(diary: NewDiary?, navigationController: UINavigationController, dependencies: DiarySceneFlowCoordinatorDependencies) {
        self.diary = diary
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    public func start() -> UIViewController {
        if let diary = diary {
            return transition(
                scene: DiaryWriteScene.detail(
                    dependencies.makeDiaryDetailViewModel(
                        diary: diary,
                        actions: .init(
                            close: close,
                            showOptionMenu: showOptionMenu(completion:),
                            showDiaryWriteScene: showDiaryWriteScene(diary:)
                        )
                    )
                ),
                transitionStyle: .push,
                animated: true
            )
        } else {
            return transition(
                scene: DiaryWriteScene.write(
                    dependencies.makeDiaryWriteViewModel(
                        diary: nil,
                        actions: .init(
                            close: close,
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
                            showDatePicker: showDatePicker(date:),
                            showDiaryDetail: showDiaryDetailScene(diary:)
                        )
                    )
                ),
                transitionStyle: .push,
                animated: true
            )
        }
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
    
    private func close() {
        self.close(animated: true)
    }
    
    private func showOptionMenu(completion: @escaping (DiaryOption)-> Void) {
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        controller.addAction(.init(title: "Cancel".localized, style: .cancel) { _ in
            completion(.cancel)
        })
        controller.addAction(.init(title: "Modify".localized, style: .default) { _ in
            completion(.modify)
        })
        controller.addAction(.init(title: "Delete".localized, style: .destructive) { _ in
            completion(.delete)
        })
        self.navigationController.visibleViewController?.present(controller, animated: true)
    }
    
    private func showDiaryDetailScene(diary: NewDiary) {
        close(animated: false)
        
        transition(
            scene: DiaryWriteScene.detail(
                dependencies.makeDiaryDetailViewModel(
                    diary: diary,
                    actions: .init(
                        close: close,
                        showOptionMenu: showOptionMenu(completion:),
                        showDiaryWriteScene: showDiaryWriteScene(diary:)
                    )
                )
            ),
            transitionStyle: .push,
            animated: true
        )
    }
    
    private func showDiaryWriteScene(diary: NewDiary) {
        close(animated: false)
        
        transition(
            scene: DiaryWriteScene.write(
                dependencies.makeDiaryWriteViewModel(
                    diary: diary,
                    actions: .init(
                        close: close,
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
                        showDatePicker: showDatePicker(date:),
                        showDiaryDetail: showDiaryDetailScene(diary:)
                    )
                )
            ),
            transitionStyle: .push,
            animated: true
        )
    }
}
