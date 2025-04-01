//
//  Emotion.swift
//  DomainWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUI
import UIKit

public enum Emotion: Int16, CaseIterable {
    case happy = 0
    case excited
    case normal
    case surprised
    case bad
    case scared
    case sad
    case angry
    
    public var string: String {
        switch self {
        case .happy: return "Happy".localized
        case .excited: return "Excited".localized
        case .normal: return "Normal".localized
        case .surprised: return "Surprised".localized
        case .bad: return "Bad".localized
        case .scared: return "Scared".localized
        case .sad: return "Sad".localized
        case .angry: return "Angry".localized
        }
    }
    
    public var emoji: String {
        switch self {
        case .happy: return "😊"
        case .angry: return "😡"
        case .bad: return "😩"
        case .excited: return "🥰"
        case .scared: return "😱"
        case .surprised: return "😮"
        case .sad: return "😢"
        case .normal: return "😐"
        }
    }
    
    public var color: UIColor {
        switch self {
        case .happy: return UIColor.yellow
        case .angry: return .red
        case .bad: return .systemPink
        case .scared: return .gray
        case .sad: return .purple
        case .normal: return .green
        case .excited: return .orange
        case .surprised: return .cyan
        }
    }
}
