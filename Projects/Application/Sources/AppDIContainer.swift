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

final class AppDIContainer {
    func makeSplashSceneDIContainer()-> any SplashSceneDIContainer {
        return DefaultSplashSceneDIContainer()
    }
}
