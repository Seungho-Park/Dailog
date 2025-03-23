//
//  DefaultPhotoViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import DomainPhotoInterfaces
import FeaturePhotoInterfaces
import RxSwift
import CoreStorageInterfaces

public final class DefaultCameraViewModel: CameraViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let actions: CameraViewModelAction
    
    public let savePhotoUsecaes: SavePhotoUsecase
    
    public init(savePhotoUsecaes: SavePhotoUsecase, actions: CameraViewModelAction) {
        self.savePhotoUsecaes = savePhotoUsecaes
        self.actions = actions
    }
    
    public func transform(input: CameraViewModelInput) -> CameraViewModelOutput {
        input.close
            .debug()
            .withUnretained(self)
            .flatMap { owner, data in
                return owner.savePhotoUsecaes.execute(data: data)
            }
            .debug()
            .map { file-> FileInfo? in return file }
            .catchAndReturn(nil)
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        return .init()
    }
}
