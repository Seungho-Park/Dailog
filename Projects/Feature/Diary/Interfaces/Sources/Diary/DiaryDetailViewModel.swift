//
//  DiaryDetailViewModel.swift
//  FeatureDiary
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import SharedUIInterfaces
import DomainDiaryInterfaces
import DomainPhotoInterfaces
import RxSwift
import RxCocoa

public struct DiaryDetailViewModelAction {
    
    public let close: ()-> Void
    public let showOptionMenu: (@escaping (DiaryOption)-> Void)-> Void
    public let showDiaryWriteScene: (Diary)-> Void
    
    public init(
        close: @escaping ()-> Void,
        showOptionMenu: @escaping (@escaping (DiaryOption)-> Void)-> Void,
        showDiaryWriteScene: @escaping (Diary)-> Void
    ) {
        self.close = close
        self.showOptionMenu = showOptionMenu
        self.showDiaryWriteScene = showDiaryWriteScene
    }
}

public struct DiaryDetailViewModelInput {
    
    public let backButtonTapped: Observable<Void>?
    public let moreButtonTapped: Observable<Void>?
    
    public init(
        backButtonTapped: Observable<Void>?,
        moreButtonTapped: Observable<Void>?
    ) {
        self.backButtonTapped = backButtonTapped
        self.moreButtonTapped = moreButtonTapped
    }
}

public struct DiaryDetailViewModelOutput {
    public let diary: Driver<Diary>
    
    public init(
        diary: Driver<Diary>
    ) {
        self.diary = diary
    }
}

public protocol DiaryDetailViewModel: ViewModel where Input == DiaryDetailViewModelInput, Output == DiaryDetailViewModelOutput {
    var diary: Diary { get }
    var actions: DiaryDetailViewModelAction { get }
    
    var deleteDiaryUsecase: DeleteDiaryUsecase { get }
    var deletePhotoFileUsecase: DeletePhotoFileUsecase { get }
}
