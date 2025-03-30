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
        let totalPages = BehaviorRelay(value: 1)
        let diariesRelay = BehaviorRelay<[Diary]>(value: [])
        let filter: BehaviorRelay<HistoryFilterType> = .init(value: .all)
        
        
        let loadNextPage = input.willDisplayCell
            .withLatestFrom(diariesRelay) { (index, diaries) -> Bool in
                return !diaries.isEmpty && index == diaries.count-1
            }
            .distinctUntilChanged()
            .filter { $0 }
            .withLatestFrom(currentPage)
            .map { $0 + 1 } // 다음 페이지 요청
            .filter { $0 <= totalPages.value }
        
        let fetchNewDiaries =
        Observable.merge(
            Observable.merge(
                input.viewWillAppear,
                filter.map { _ in }.asObservable()
            )
            .map { 1 },
            loadNextPage
            )
            .withUnretained(self)
            .flatMapLatest { owner, page in
                var year: Int? = nil
                var month: Int? = nil
                switch filter.value {
                case .all: break
                case .year(let value):
                    year = value
                    month = nil
                case .month(let yValue, let mValue):
                    year = yValue
                    month = mValue
                }
                
                return owner.fetchDiariesUsecase.execute(year: year, month: month, page: page, count: 20)
                    .catchAndReturn(Diaries(currentPage: page, totalPages: 1, diaries: []))
            }
            .share()
        
        fetchNewDiaries
            .subscribe(onNext: { diaries in
                if diaries.currentPage == 1 {
                    diariesRelay.accept(diaries.diaries) // 첫 페이지는 덮어쓰기
                } else {
                    diariesRelay.accept(diariesRelay.value + diaries.diaries) // 페이징 데이터 추가
                }
                currentPage.accept(diaries.currentPage)
                totalPages.accept(diaries.totalPages)
            })
            .disposed(by: disposeBag)
        
        input.filterButtonTapped?
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.actions.showSelectFilter(filter.value)
            }
            .compactMap { $0 }
            .bind(to: filter)
            .disposed(by: disposeBag)
        
        return .init(
            items: diariesRelay
                .withUnretained(self)
                .flatMapLatest { owner, diaries -> Observable<[DiaryListItemViewModel]> in
                    if diaries.isEmpty { return Observable.just([]) }
                    let itemObservables = diaries.map { diary in
                        owner.loadThumbnail(for: diary)
                    }
                    return Observable.zip(itemObservables)
                }
                .asDriver(onErrorJustReturn: []),
            
            filter: filter
                .map {
                    switch $0 {
                    case .all: return "All".localized
                    case .year(let year):
                        let formatter = DateFormatter()
                        formatter.locale = Locale.getLocaleFromLangCode()
                        formatter.dateFormat = "yyyy"
                        let date = formatter.date(from: "\(year)")
                        formatter.setLocalizedDateFormatFromTemplate("yyyy")
                        return formatter.string(from: date!)
                    case .month(let year, let month):
                        let formatter = DateFormatter()
                        formatter.locale = Locale.getLocaleFromLangCode()
                        formatter.dateFormat = "yyyyMM"
                        let date = formatter.date(from: "\(year)\(String(format: "%02d", month))")
                        formatter.setLocalizedDateFormatFromTemplate("yyyy MMM")
                        return formatter.string(from: date!)
                    }
                }
                .asDriver(onErrorJustReturn: "All".localized)
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
                        image: fileInfo.data.resizeImageData(maxPixelSize: 200),
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
