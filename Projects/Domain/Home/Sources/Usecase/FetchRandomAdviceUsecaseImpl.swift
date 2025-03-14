//
//  FetchRandomAdviceUsecaseImpl.swift
//  DomainHome
//
//  Created by 박승호 on 3/14/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import DomainHomeInterfaces
import Foundation

public final class FetchRandomAdviceUsecaseImpl: FetchRandomAdviceUsecase {
    private let repository: HomeRepository
    
    public init(repository: HomeRepository) {
        self.repository = repository
    }
    
    public func execute() -> Single<AdviceList.Advice.Translation> {
        Single<AdviceList.Advice.Translation>.create { [weak self] single in
            guard let self = self else { return Disposables.create() }
            self.repository.fetchAdviceList { result in
                switch result {
                case .success(let list):
                    let advice = list.advices.randomElement() ?? list.advices.first!
                    var trans: AdviceList.Advice.Translation? = nil
                    switch Locale.preferredLanguages.first?.split(separator: "-")[0] ?? "en" {
                    case "ko":
                        trans = advice.translation["ko"]
                    case "ar":
                        trans = advice.translation["ar"]
                    case "vi":
                        trans = advice.translation["vi"]
                    case "th":
                        trans = advice.translation["th"]
                    case "ja":
                        trans = advice.translation["ja"]
                    case "en":
                        trans = advice.translation["en"]
                    default: trans = advice.translation["en"]
                    }
                    
                    single(.success(trans ?? advice.translation["en"]!))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return Disposables.create()
        }
    }
}
