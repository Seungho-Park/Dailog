//
//  DefaultApplicationStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreStorageInterfaces
import Foundation

public final class DefaultApplicationStorage: ApplicationStorage {
    private let storage: UserDefaults
    
    public init(storage: UserDefaults = .standard) {
        self.storage = storage
    }
    
    public func isPasscodeRegistered(completion: @escaping (Bool) -> Void) {
        completion(storage.string(forKey: CodingKeys.passcode.rawValue) != nil)
    }
    
    public func isPasscodeVerified(passcode: String, completion: @escaping (Bool) -> Void) {
        guard let stored = storage.string(forKey: CodingKeys.passcode.rawValue) else {
            completion(false)
            return
        }
        
        completion(stored == passcode)
    }
    
    public func savePasscode(passcode: String, completion: @escaping (Bool) -> Void) {
        storage.set(passcode, forKey: CodingKeys.passcode.rawValue)
        storage.synchronize()
        completion(true)
    }
    
    public func removePasscode(completion: @escaping (Bool) -> Void) {
        storage.removeObject(forKey: CodingKeys.passcode.rawValue)
        storage.synchronize()
    }
    
    private enum CodingKeys: String, CodingKey {
        case passcode = "net.devswift.dailog.application.passcode"
    }
}
