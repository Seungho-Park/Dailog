//
//  FetchRandomPromptUsecaseImpl.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import DomainHomeInterfaces
import Foundation

public final class FetchRandomPromptUsecaseImpl: FetchRandomPromptUsecase {
    private let repository: HomeRepository
    
    public init(repository: HomeRepository) {
        self.repository = repository
    }
    
    public func execute() -> Single<Prompts.Prompt.Translation> {
        return Single<Prompts.Prompt.Translation>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.repository.fetchPrompts { result in
                switch result {
                case .success(let prompts):
                    let prompt = prompts.prompts.randomElement() ?? prompts.prompts.first!
                    
                    var trans: Prompts.Prompt.Translation? = nil
                    switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
                    case "ko":
                        trans = prompt.translations["ko"]
                    case "ar":
                        trans = prompt.translations["ar"]
                    case "vi":
                        trans = prompt.translations["vi"]
                    case "th":
                        trans = prompt.translations["th"]
                    case "ja":
                        trans = prompt.translations["ja"]
                    case "en":
                        trans = prompt.translations["en"]
                    default: trans = prompt.translations["en"]
                    }
                    
                    single(.success(trans ?? prompt.translations["en"]!))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
