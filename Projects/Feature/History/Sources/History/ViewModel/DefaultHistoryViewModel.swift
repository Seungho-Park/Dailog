//
//  DefaultHistoryViewModel.swift
//  FeatureHistory
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SharedUIInterfaces
import FeatureHistoryInterfaces
import DomainDiaryInterfaces
import DomainPhotoInterfaces
import CoreStorageInterfaces

public final class DefaultHistoryViewModel: HistoryViewModel {
    public let fetchDiariesUsecase: FetchDiariesUsecase
    public let fetchPhotoDataUsecase: FetchPhotoDataUsecase
    public let actions: HistoryViewModelAction
    public let disposeBag: DisposeBag = DisposeBag()
    
    public init(
        fetchDiariesUsecase: FetchDiariesUsecase,
        fetchPhotoDataUsecase: FetchPhotoDataUsecase,
        actions: HistoryViewModelAction
    ) {
        self.fetchDiariesUsecase = fetchDiariesUsecase
        self.fetchPhotoDataUsecase = fetchPhotoDataUsecase
        self.actions = actions
    }
    
    public func transform(input: FeatureHistoryInterfaces.HistoryViewModelInput) -> FeatureHistoryInterfaces.HistoryViewModelOutput {
        let diaries: BehaviorRelay<[UUID:Diary]> = .init(value: [:])
        let itemViewModels: BehaviorRelay<[DiaryListItemViewModel]> = .init(value: [])
        let currentPage: BehaviorRelay<Int> = .init(value: 0)
        
        input.viewWillAppear
            .map { 1 }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
        
        input.willDisplayCell
            .filter { diaries.value.count > 0 && diaries.value.count == $0 }
            .map { _ in currentPage.value + 1 }
            .bind(to: currentPage)
            .disposed(by: disposeBag)
        
        let response = currentPage
            .filter { $0 > 0 }
            .distinctUntilChanged()
            .withUnretained(self)
            .flatMap { owner, page in
                owner.fetchDiariesUsecase.execute(year: nil, month: nil, page: page, count: 20)
            }
            .catchAndReturn([])
            .share()
        
        response
            .bind { list in
                var values = diaries.value
                list.forEach {
                    values.updateValue($0, forKey: $0.id)
                }
                diaries.accept(values)
            }
            .disposed(by: disposeBag)
        
        Observable.zip(
            response.asObservable(),
            response
                .withUnretained(self)
                .flatMap { owner, diaries in
                    Observable.from(diaries)
                        .withUnretained(owner)
                        .flatMap { owner, diary in
                            guard let fileName = diary.photos.first?.fileName else {
                                return Observable<FileInfo?>.just(nil)
                            }
                            
                            return owner.fetchPhotoDataUsecase.execute(fileName: fileName)
                                .map { fileInfo-> FileInfo? in return fileInfo }
                                .debug()
                                .catchAndReturn(nil)
                                .asObservable()
                        }
                        .toArray()
                }
        )
        .map { diaries, photo in
            var result: [DiaryListItemViewModel] = []
            for i in 0..<diaries.count {
                let photo = photo[i]
                result.append(DiaryListItemViewModel.init(id: diaries[i].id, emotion: diaries[i].emotion, content: diaries[i].contents, date: diaries[i].date, thumbnail: photo != nil ? .init(image: photo!.data, hasMultiple: diaries[i].photos.count > 1) : nil))
            }
            return result
        }
        .bind {
            var value = itemViewModels.value
            value.append(contentsOf: $0)
            itemViewModels.accept(value)
        }
        .disposed(by: disposeBag)
        
        input.filterButtonTapped?
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.actions.showSelectFilter()
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        return .init(
            items: itemViewModels.asDriver()
        )
    }
}
