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
        let currentPage = BehaviorRelay<Int>(value: 1)
        let diariesRelay = BehaviorRelay<[Diary]>(value: [])
        
        let loadNextPage = input.willDisplayCell
            .withLatestFrom(diariesRelay) { (index, diaries) -> Bool in
                return index >= Int(Double(diaries.count) * 0.8) // 80% 스크롤 시 로드
            }
            .distinctUntilChanged()
            .filter { $0 }
            .withLatestFrom(currentPage)
            .map { $0 + 1 } // 다음 페이지 요청
            .filter { $0 <= diariesRelay.value.count }
        
        let fetchNewDiaries = Observable
            .merge(
                input.viewWillAppear.map { 1 },
                loadNextPage
            )
            .withUnretained(self)
            .flatMapLatest { owner, page in
                return owner.fetchDiariesUsecase.execute(year: nil, month: nil, page: page, count: 20)
                    .catchAndReturn(Diaries(currentPage: page, totalPages: 1, diaries: []))
            }
            .share(replay: 1)
        
        fetchNewDiaries
            .subscribe(onNext: { diaries in
                if diaries.currentPage == 1 {
                    diariesRelay.accept(diaries.diaries) // 첫 페이지는 덮어쓰기
                } else {
                    diariesRelay.accept(diariesRelay.value + diaries.diaries) // 페이징 데이터 추가
                }
                currentPage.accept(diaries.currentPage)
            })
            .disposed(by: disposeBag)
        
        let items = diariesRelay
            .withUnretained(self)
            .flatMapLatest { owner, diaries -> Observable<[DiaryListItemViewModel]> in
                let itemObservables = diaries.map { diary in
                    owner.loadThumbnail(for: diary)
                }
                return Observable.zip(itemObservables)
            }
            .asDriver(onErrorJustReturn: [])
        
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
            items: items
        )
    }
    
    private func loadThumbnail(for diary: Diary) -> Observable<DiaryListItemViewModel> {
        guard let firstPhoto = diary.photos.first else {
            return Observable.just(DiaryListItemViewModel(
                id: diary.id,
                emotion: diary.emotion,
                content: diary.contents,
                date: diary.date,
                thumbnail: nil
            ))
        }
        
        return fetchPhotoDataUsecase.execute(fileName: firstPhoto.fileName)
            .map { fileInfo in
                DiaryListItemViewModel(
                    id: diary.id,
                    emotion: diary.emotion,
                    content: diary.contents,
                    date: diary.date,
                    thumbnail: DiaryListItemViewModel.Thumbnail(
                        image: fileInfo.data,
                        hasMultiple: diary.photos.count > 1
                    )
                )
            }
            .catchAndReturn(DiaryListItemViewModel(
                id: diary.id,
                emotion: diary.emotion,
                content: diary.contents,
                date: diary.date,
                thumbnail: nil
            ))
            .asObservable()
    }
}
