//
//  Data+Extension.swift
//  SharedUI
//
//  Created by 박승호 on 3/30/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreGraphics
import ImageIO
import AVFoundation

public extension Data {
    func resizeImageData(maxPixelSize: Int, quality: CGFloat = 0.8)-> Data {
        let options: [CFString: Any] = [kCGImageSourceShouldCache: false]
        guard let source = CGImageSourceCreateWithData(self as CFData, options as CFDictionary)
        else {
            return self
        }
        
        let resizeOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceShouldCacheImmediately: false
        ]
        
        guard let resizedCGImage = CGImageSourceCreateThumbnailAtIndex(source, 0, resizeOptions as CFDictionary) else {
            print("이미지 리사이징 실패")
            return self
        }
        
        let data = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(data, AVFileType.heic as CFString, 1, nil) else {
            print("HEIC 데이터 변환 실패")
            return self
        }
        
        let saveOptions: [CFString: Any] = [kCGImageDestinationLossyCompressionQuality: quality]
        CGImageDestinationAddImage(destination, resizedCGImage, saveOptions as CFDictionary)
        
        guard CGImageDestinationFinalize(destination) else {
            print("HEIC 데이터 변환 최종화 실패")
            return self
        }
        
        return data as Data
    }
}
