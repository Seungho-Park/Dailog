//
//  SceneDelegate.swift
//  Dailog
//
//  Created by 박승호 on 6/27/25.
//

import UIKit
import Shared

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var appComponent: AppComponent!
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        registerProviderFactories()
        appComponent = AppComponent()
        
        window?.rootViewController = appComponent.rootViewController
        window?.makeKeyAndVisible()
    }
}

