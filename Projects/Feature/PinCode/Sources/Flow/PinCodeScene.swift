//
//  PinCodeScene.swift
//  FeaturePinCode
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeaturePinCodeInterfaces

extension FeaturePinCodeInterfaces.PinCodeScene: SharedUIInterfaces.Scene {
    public func instantiate() -> UIViewController {
        switch self {
        case .pinCode(let vm):
            return PinCodeViewController.create(viewModel: vm as! DefaultPinCodeViewModel)
        }
    }
}
