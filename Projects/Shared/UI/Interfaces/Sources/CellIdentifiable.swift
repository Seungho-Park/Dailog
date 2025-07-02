//
//  CellIdentifiable.swift
//  SharedUI
//
//  Created by 박승호 on 7/2/25.
//

public protocol CellIdentifiable {
    var identifier: String { get }
}

public extension CellIdentifiable {
    var identifier: String {
        return String(describing: self)
    }
}
