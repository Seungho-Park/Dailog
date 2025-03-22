//
//  PhotoSize.swift
//  CorePhoto
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreFoundation

public enum PhotoSize {
    case original
    case thumbnail
    
    public var size: CGSize {
        switch self {
        case .original: return .zero
        case .thumbnail: return .init(width: 200, height: 200)
        }
    }
}
