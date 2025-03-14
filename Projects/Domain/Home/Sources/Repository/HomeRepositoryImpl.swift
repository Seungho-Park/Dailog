//
//  HomeRepositoryImpl.swift
//  Domain
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import DomainHomeInterfaces
import SharedUI
import Foundation

public final class HomeRepositoryImpl: HomeRepository {
    public init() {
        
    }
    
    public func fetchPrompts(completion: @escaping (Result<Prompts, Error>)-> Void) {
        if let path = Bundle.sharedUI.path(forResource: "Prompt", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(try JSONDecoder().decode(Prompts.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(URLError.init(.cannotOpenFile)))
        }
    }
    
    public func fetchAdviceList(completion: @escaping (Result<AdviceList, any Error>) -> Void) {
        if let path = Bundle.sharedUI.path(forResource: "AdviceList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                completion(.success(try JSONDecoder().decode(AdviceList.self, from: data)))
            } catch {
                completion(.failure(error))
            }
        } else {
            completion(.failure(URLError.init(.cannotOpenFile)))
        }
    }
}
