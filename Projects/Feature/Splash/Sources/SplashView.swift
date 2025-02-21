//
//  SplashView.swift
//  FeatureSplash
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import SwiftUI
import SharedUI
import ComposableArchitecture
import FeatureSplashInterfaces

public struct SplashView<Store: SplashStore>: View {
    public let store: StoreOf<Store>
    
    public init(store: StoreOf<Store>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            DailogView {
                GeometryReader { geometry in
                    VStack(spacing: 25) {
                        Text("AppName".localized)
                            .font(.jalnan(56))
                        
                        Text("AppSubTitle".localized)
                            .font(.jalnan(17))
                    }
                    .frame(width: geometry.size.width)
                    .position(
                        x: geometry.size.width/2,
                        y: geometry.size.height/2.5
                    )
                }
                .background {
                    Image.bgLaunchScreen
                }
                .onAppear {
                    viewStore.send(.didAppear)
                }
            }
        }
    }
}
