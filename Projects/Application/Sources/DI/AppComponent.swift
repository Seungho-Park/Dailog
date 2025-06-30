//
//  AppComponent.swift
//  Dailog
//
//  Created by 박승호 on 6/27/25.
//

import UIKit
import Feature
import Shared

final class AppComponent: BootstrapComponent {
    
    var rootViewController: UIViewController {
        return featureComponent.coordinator.start()
    }
    
    public var featureComponent: FeatureBuilder {
        shared { FeatureComponent(parent: self) }
    }
}
