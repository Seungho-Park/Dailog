//
//  AppAppearance.swift
//  SharedUI
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreGraphics
import CoreText

public final class UIAppearance {
    private init() {  }
    
    public static func setup() {
        do {
            try loadFont()
        } catch {
            print(error)
        }
    }
    
    private static func loadFont() throws {
        if let fontUrl = Bundle.module.url(forResource: "Jalnan2", withExtension: "otf"),
           let dataProvider = CGDataProvider(url: fontUrl as CFURL),
           let newFont = CGFont(dataProvider) {
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(newFont, &error) {
                throw LoadError.font
            }
        } else {
            throw LoadError.font
        }
    }
}
