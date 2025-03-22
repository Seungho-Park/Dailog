//
//  DefaultPhotoViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import FeaturePhotoInterfaces
import RxSwift

public final class DefaultCameraViewModel: CameraViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let actions: CameraViewModelAction
    
    public init(actions: CameraViewModelAction) {
        self.actions = actions
    }
    
    public func transform(input: CameraViewModelInput) -> CameraViewModelOutput {
        return .init()
    }
}
