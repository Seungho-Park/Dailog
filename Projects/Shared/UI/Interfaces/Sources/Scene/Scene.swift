//
//  Scene.swift
//  SharedUI
//
//  Created by 박승호 on 2/22/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import UIKit

public protocol Scene {
    
    func instantiate()-> UIViewController
}
