//
//  DiaryWriteScene.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/18/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public enum DiaryWriteScene {
    case write(any DiaryWriteViewModel)
    case emotion(any EmotionViewModel)
    case datePicker(any DatePickerViewModel)
}
