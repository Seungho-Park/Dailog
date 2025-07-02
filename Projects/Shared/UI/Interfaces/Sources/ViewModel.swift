//
//  ViewModel.swift
//  SharedUI
//
//  Created by 박승호 on 6/27/25.
//

public protocol ViewModel {
    associatedtype Action
    associatedtype Input
    associatedtype Output
    
    var action: Action { get }
    
    func transform(input: Input)-> Output
}
