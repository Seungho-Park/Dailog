//
//  HomeRepository.swift
//  Domain
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public protocol HomeRepository {
    func fetchPrompts(completion: @escaping (Result<Prompts, Error>)-> Void)
    func fetchAdviceList(completion: @escaping (Result<AdviceList, Error>)-> Void)
}
