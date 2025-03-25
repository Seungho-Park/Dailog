//
//  AppDIContainer.swift
//  Dailog
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import UIKit
import FeatureSplash
import FeatureSplashInterfaces
import FeatureMain
import FeatureMainInterfaces
import FeatureHome
import FeatureHomeInterfaces
import FeatureHistory
import FeatureHistoryInterfaces
import SharedUIInterfaces
import FeatureReminder
import FeatureReminderInterfaces
import FeatureSettings
import FeatureSettingsInterfaces
import FeatureDiary
import FeatureDiaryInterfaces
import FeaturePhoto
import FeaturePhotoInterfaces
import CorePhotoInterfaces
import CorePhoto
import CoreStorage
import CoreStorageInterfaces

final class AppDIContainer {
    private let config = ApplicationConfig()
    private lazy var photoService: PhotoService = DefaultPhotoService()
    private lazy var imageFileStorage: FileStorage = ImageFileStorage()
    private lazy var coreDataStorage: CoreDataStorage = DefaultCoreDataStorage()
    
    func makeSplashSceneDIContainer()-> SplashSceneDIContainer {
        return DefaultSplashSceneDIContainer(
            dependencies: .init(
                mainSceneDIContainer: makeMainSceneDIContainer()
            )
        )
    }
    
    func saveContext() {
        coreDataStorage.save()
    }
    
    private func makeMainSceneDIContainer()-> MainSceneDIContainer {
        return DefaultMainSceneDIContainer(
            dependencies: .init(
                homeSceneDIContainer: makeHomeSceneDIContainer(),
                historySceneDIContainer: makeHistorySceneDIContainer(),
                reminderSceneDIContainer: makeReminderSceneDIContainer(),
                settingsSceneDIContainer: makeSettingsSceneDIContainer()
            )
        )
    }
    
    private func makeHomeSceneDIContainer()-> HomeSceneDIContainer {
        return DefaultHomeSceneDIContainer(dependencies: .init(
            diaryWriteDIContainer: makeDiaryWriteSceneDIContainer()
        ))
    }
    
    private func makeHistorySceneDIContainer()-> HistorySceneDIContainer {
        return DefaultHistorySceneDIContainer()
    }
    
    private func makeReminderSceneDIContainer()-> ReminderSceneDIContainer {
        return DefaultReminderSceneDIContainer()
    }
    
    private func makeSettingsSceneDIContainer()-> SettingsSceneDIContainer {
        return DefaultSettingsSceneDIContainer()
    }
    
    private func makeDiaryWriteSceneDIContainer()-> DiarySceneDIContainer {
        return DefaultDiarySceneDIContainer(dependencies: .init(photoService: photoService, photoSceneDIContainer: makePhotoSceneDIContainer(), imageStorage: imageFileStorage, diaryStorage: DiaryCoreDataStorage(coreDataStorage: coreDataStorage)))
    }
    
    private func makePhotoSceneDIContainer()-> PhotoSceneDIContainer {
        return DefaultPhotoSceneDIContainer(dependencies: .init(photoService: photoService, imageStorage: imageFileStorage))
    }
}
