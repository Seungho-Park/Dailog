//
//  DefaultDiaryDetailViewModel.swift
//  FeatureDiary
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import SharedUIInterfaces
import FeatureDiaryInterfaces
import DomainDiaryInterfaces
import DomainPhotoInterfaces

public final class DefaultDiaryDetailViewModel: DiaryDetailViewModel {
    public let disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public let diary: Diary
    public let deleteDiaryUsecase: DeleteDiaryUsecase
    public let deletePhotoFileUsecase: DeletePhotoFileUsecase
    public let actions: DiaryDetailViewModelAction
    
    public init(
        diary: Diary,
        deleteDiaryUsecase: DeleteDiaryUsecase,
        deletePhotoFileUsecase: DeletePhotoFileUsecase,
        actions: DiaryDetailViewModelAction
    ) {
        self.diary = diary
        self.deleteDiaryUsecase = deleteDiaryUsecase
        self.deletePhotoFileUsecase = deletePhotoFileUsecase
        self.actions = actions
    }
    
    public func transform(input: DiaryDetailViewModelInput) -> DiaryDetailViewModelOutput {
        
        input.backButtonTapped?
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        let optionSelect = input.moreButtonTapped?
            .withUnretained(self)
            .flatMap { owner, _ in
                Observable<DiaryOption>.create { [weak owner] observer in
                    guard let owner else {
                        observer.onCompleted()
                        return Disposables.create()
                    }
                    owner.actions.showOptionMenu() { option in
                        observer.onNext(option)
                        observer.onCompleted()
                    }
                    return Disposables.create()
                }
            }
            .share()
        
        optionSelect?
            .filter { $0 == .delete }
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.deleteDiaryUsecase.execute(diary: owner.diary)
            }
            .catchAndReturn(false)
            .filter { $0 }
            .withUnretained(self)
            .map { owner, _ in return owner.diary.photos }
            .withUnretained(self)
            .flatMap { owner, photos in
                Observable.from(photos)
                    .flatMap { [unowned owner] photo in
                        owner.deletePhotoFileUsecase.execute(fileName: photo.fileName)
                    }
                    .toArray()
            }
            .map { _ in }
            .observe(on: MainScheduler.asyncInstance)
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        optionSelect?
            .filter { $0 == .modify }
            .withUnretained(self)
            .map { owner, _ in return owner.diary }
            .bind(onNext: actions.showDiaryWriteScene)
            .disposed(by: disposeBag)
        
        return .init(
            diary: Observable.just(diary).asDriver(onErrorJustReturn: nil).compactMap { $0 }
        )
    }
}
