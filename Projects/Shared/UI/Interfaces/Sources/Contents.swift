//
//  Contents.swift
//  SharedUI
//
//  Created by 박승호 on 2/20/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import ComposableArchitecture

public protocol DailogStore: Reducer {
    var reduce: Reduce<State, Action> { get }
}

public extension DailogStore {
    var body: some Reducer<State, Action> {
        reduce
    }
}
