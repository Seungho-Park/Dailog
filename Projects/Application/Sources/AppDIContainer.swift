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
import FeatureWrite
import FeatureWriteInterfaces
import FeaturePhoto
import FeaturePhotoInterfaces
import CorePhotoInterfaces
import CorePhoto

final class AppDIContainer {
    private let config = ApplicationConfig()
    private lazy var photoService: PhotoService = DefaultPhotoService()
    
    func makeSplashSceneDIContainer()-> SplashSceneDIContainer {
        return DefaultSplashSceneDIContainer(
            dependencies: .init(
                mainSceneDIContainer: makeMainSceneDIContainer()
            )
        )
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
    
    private func makeDiaryWriteSceneDIContainer()-> WriteSceneDIContainer {
        return DefaultWriteSceneDIContainer(dependencies: .init(photoService: photoService, photoSceneDIContainer: makePhotoSceneDIContainer()))
    }
    
    private func makePhotoSceneDIContainer()-> PhotoSceneDIContainer {
        return DefaultPhotoSceneDIContainer(dependencies: .init(photoService: photoService))
    }
}
