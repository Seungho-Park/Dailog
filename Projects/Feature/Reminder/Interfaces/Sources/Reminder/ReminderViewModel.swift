//
//  ReminderViewModel.swift
//  FeatureReminder
//
//  Created by 박승호 on 3/13/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import RxSwift
import RxCocoa
import SharedUIInterfaces
import DomainDiaryInterfaces

public struct ReminderViewModelInput {
    public let viewWillAppear: Observable<Void>
    public let prevDateButtonTapped: Observable<Void>
    public let nextDateButtonTapped: Observable<Void>
    
    public init(
        viewWillAppear: Observable<Void>,
        prevDateButtonTapped: Observable<Void>,
        nextDateButtonTapped: Observable<Void>
    ) {
        self.viewWillAppear = viewWillAppear
        self.prevDateButtonTapped = prevDateButtonTapped
        self.nextDateButtonTapped = nextDateButtonTapped
    }
}

public struct ReminderViewModelOutput {
    public let date: Driver<String>
    public let diaries: Driver<[NewDiary]>
    public let emotions: Driver<[Emotion:Int]>
    public let monthlyReport: Driver<[String:Int]>
    
    public init(
        date: Driver<String>,
        diaries: Driver<[NewDiary]>,
        emotion: Driver<[Emotion:Int]>,
        monthlyReport: Driver<[String:Int]>
    ) {
        self.date = date
        self.diaries = diaries
        self.emotions = emotion
        self.monthlyReport = monthlyReport
    }
}

public protocol ReminderViewModel: ViewModel where Input == ReminderViewModelInput, Output == ReminderViewModelOutput {
    var fetchDiariesUsecase: FetchDiariesUsecase { get }
}
