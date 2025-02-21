//
//  MainView.swift
//  FeatureMain
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import SharedUI
import FeatureMainInterfaces

public struct MainView<Store: MainStore>: View {
    let store: StoreOf<Store>
    
    public init(store: StoreOf<Store>) {
        self.store = store
    }
    
    public var body: some View {
        NavigationStack {
            DailogView {
                
            }
        }
    }
}
