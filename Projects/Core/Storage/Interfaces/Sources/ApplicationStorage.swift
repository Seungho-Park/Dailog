//
//  ApplicationStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 4/2/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

public enum ApplicationStorageError: Error {
    
}

public protocol ApplicationStorage {
    func isPasscodeRegistered(completion: @escaping (Bool)-> Void)
    func isPasscodeVerified(passcode: String, completion: @escaping (Bool)-> Void)
    func savePasscode(passcode: String, completion: @escaping (Bool)-> Void)
    func removePasscode(completion: @escaping (Bool)-> Void)
}
