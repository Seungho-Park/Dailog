//
//  PhotoViewModel.swift
//  FeaturePhoto
//
//  Created by 박승호 on 3/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces

public struct CameraViewModelAction {
    
    public init() {  }
}

public struct CameraViewModelInput {
    
    public init() {  }
}

public struct CameraViewModelOutput {
    
    public init() {  }
}

public protocol CameraViewModel: ViewModel where Input == CameraViewModelInput, Output == CameraViewModelOutput {
    var actions: CameraViewModelAction { get }
}
