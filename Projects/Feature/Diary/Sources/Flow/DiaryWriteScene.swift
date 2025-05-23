//
//  DiaryWriteScene.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import UIKit
import SharedUIInterfaces
import FeatureDiaryInterfaces

extension FeatureDiaryInterfaces.DiaryWriteScene: SharedUIInterfaces.Scene {
    
    public func instantiate() -> UIViewController {
        switch self {
        case .write(let viewModel):
            return DiaryWriteViewController<DefaultDiaryWriteViewModel>.create(viewModel: viewModel as! DefaultDiaryWriteViewModel)
        case .emotion(let viewModel):
            let vc = EmotionViewController<DefaultEmotionViewModel>.create(viewModel: viewModel as! DefaultEmotionViewModel)
            vc.modalPresentationStyle = .fullScreen
            return vc
        case .datePicker(let viewModel):
            let vc = DatePickerViewController.create(viewModel: viewModel as! DefaultDatePickerViewModel)
            vc.modalPresentationStyle = .overFullScreen
            return vc
        case .detail(let vm):
            return DiaryDetailViewController.create(viewModel: vm as! DefaultDiaryDetailViewModel)
        }
    }
}
