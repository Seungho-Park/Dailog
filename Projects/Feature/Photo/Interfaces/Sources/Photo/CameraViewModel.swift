//
//  PhotoViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import SharedUIInterfaces
import DomainPhotoInterfaces
import RxSwift
import RxCocoa
import CoreStorageInterfaces

public struct CameraViewModelAction {
    public let close: (FileInfo?)-> Void
    public init(
        close: @escaping (FileInfo?)-> Void
    ) {
        self.close = close
    }
}

public struct CameraViewModelInput {
    public let close: Observable<Data?>
    public init(
        close: Observable<Data?>
    ) {
        self.close = close
    }
}

public struct CameraViewModelOutput {
    
    public init() {  }
}

public protocol CameraViewModel: ViewModel where Input == CameraViewModelInput, Output == CameraViewModelOutput {
    var actions: CameraViewModelAction { get }
    var savePhotoUsecaes: SavePhotoUsecase { get }
}
