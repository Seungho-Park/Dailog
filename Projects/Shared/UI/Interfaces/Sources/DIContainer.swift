//
//  DIConatiner.swift
//  SharedUI
//
//  Created by 박승호 on 2/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//
import UIKit

public protocol DIContainer {
    
    func makeCoordinator(navController: UINavigationController)-> Coordinator
}
