//
//  DailogView.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI

public struct DailogView<Content: View>: View {
    let content: Content
    
    public init(@ViewBuilder content: ()-> Content) {
        self.content = content()
    }
    
    public var body: some View {
        content
            .background {
                Image.bgLaunchScreen
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            }
    }
}
