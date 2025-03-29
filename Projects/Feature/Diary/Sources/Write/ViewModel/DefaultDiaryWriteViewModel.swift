//
//  DefaultDiaryWriteViewModel.swift
//  FeatureWrite
//
//  Created by 박승호 on 3/17/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUI
import FeatureDiaryInterfaces
import SharedUIInterfaces
import RxSwift
import RxCocoa
import DomainDiaryInterfaces
import DomainPhotoInterfaces
import CoreStorageInterfaces
import Photos

public final class DefaultDiaryWriteViewModel: DiaryWriteViewModel {
    public var disposeBag: DisposeBag = DisposeBag()
    public let background: BackgroundType = .image(.bgLaunchScreen)
    
    public let diary: Diary?
    public let fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase
    public let fetchPhotoDataUsecase: FetchPhotoDataUsecase
    public let deletePhotoFileUsecase: DeletePhotoFileUsecase
    public let saveDiaryUsecase: SaveDiaryUsecase
    public let actions: DiaryWriteViewModelAction
    
    public init(
        diary: Diary?,
        fetchPhotoAssetsUsecase: FetchPhotoAssetsUsecase,
        fetchPhotoDataUsecase: FetchPhotoDataUsecase,
        deletePhotoFileUsecase: DeletePhotoFileUsecase,
        saveDiaryUsecase: SaveDiaryUsecase,
        actions: DiaryWriteViewModelAction
    ) {
        self.diary = diary
        self.fetchPhotoAssetsUsecase = fetchPhotoAssetsUsecase
        self.fetchPhotoDataUsecase = fetchPhotoDataUsecase
        self.deletePhotoFileUsecase = deletePhotoFileUsecase
        self.saveDiaryUsecase = saveDiaryUsecase
        self.actions = actions
    }
    
    public func transform(input: DiaryWriteViewModelInput) -> DiaryWriteViewModelOutput {
        let emotion: BehaviorRelay<Emotion?> = .init(value: diary?.emotion)
        let contents: BehaviorRelay<String> = .init(value: diary?.contents ?? "")
        let date: BehaviorRelay<Date> = .init(value: diary?.createdAt ?? Date())
        let photos: BehaviorRelay<[FileInfo]> = .init(value: [])
        
        Observable.merge(
            input.emotionButtonTapped,
            emotion.take(1).filter { $0 == nil }.map { _ in }
        )
        .withUnretained(self)
        .flatMap { owner, _ in
            return owner.actions.showSelectEmotion()
        }
        .bind(to: emotion)
        .disposed(by: disposeBag)
        
        Observable<Bool>.create { observer in
            observer.onNext(PHPhotoLibrary.authorizationStatus() == .authorized)
            observer.onCompleted()
            return Disposables.create()
        }
        .filter { $0 }
        .withUnretained(self)
        .flatMap { owner, _ in
            owner.fetchPhotoAssetsUsecase.execute(size: .thumbnail)
        }
        .subscribe { event in
            if let error = event.error {
                print("에셋 미리 로드 실패: \(error)")
            } else {
                print("에셋 로드 성공.")
            }
        }
        .disposed(by: disposeBag)
        
        input.backButtonTapped?
            .bind(onNext: actions.close)
            .disposed(by: disposeBag)
        
        Observable.merge(
            input.addPhotoButtonTapped
                .withUnretained(self)
                .flatMap { owner, _ in
                    return owner.actions.showPhotoAlbum()
                },
            input.captureCameraButtonTapped
                .withUnretained(self)
                .flatMap { owner, _ in
                    owner.actions.showDeviceCamera()
                }
        )
        .filter { !$0.isEmpty }
        .bind {
            var values = photos.value
            values.append(contentsOf: $0)
            photos.accept(values)
        }
        .disposed(by: disposeBag)
        
        input.photoDeleteButtonTapped
            .withUnretained(self)
            .flatMap { owner, fileName in
                photos.accept(photos.value.filter { $0.fileName != fileName })
                return owner.deletePhotoFileUsecase.execute(fileName: fileName)
            }
            .retry(3)
            .subscribe { isSuccess in
                print("파일 삭제: \(isSuccess)")
            }
            .disposed(by: disposeBag)
        
        input.saveButtonTapped?
            .withUnretained(self)
            .map { owner, _ in
                Diary(id: owner.diary?.id ?? UUID(), emotion: emotion.value, contents: contents.value, date: date.value, photos: photos.value.map { Photo(fileName: $0.fileName, memo: "", createdAt: $0.createdAt) }, createdAt: owner.diary?.createdAt ?? Date(), updatedAt: Date())
            }
            .withUnretained(self)
            .flatMap { owner, diary in
                owner.saveDiaryUsecase.execute(diary: diary)
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        input.textChanged
            .bind { text in
                contents.accept(text.count > 500 ? String(text.prefix(500)) : text)
            }
            .disposed(by: disposeBag)
        
        input.dateChangeButtonTapped?
            .withUnretained(self)
            .flatMap { owner, _ in
                owner.actions.showDatePicker()
            }
            .subscribe {
                print($0)
            }
            .disposed(by: disposeBag)
        
        return .init(
            emotion: emotion.asDriver(),
            contents: contents.asDriver(),
            date: date.asDriver(),
            photos: photos.asDriver()
        )
    }
}
