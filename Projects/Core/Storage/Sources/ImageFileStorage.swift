//
//  FileStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/23/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import Foundation
import CoreStorageInterfaces
import AVFoundation

public final class ImageFileStorage: FileStorage {
    private let fileManager: FileManager
    private lazy var filePath = {
        let url = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let imageFolder = url.appendingPathComponent("Images", isDirectory: true)
        
        if !fileManager.fileExists(atPath: imageFolder.path) {
            try? fileManager.createDirectory(at: imageFolder, withIntermediateDirectories: true)
        }
        
        return imageFolder
    }()
    
    public init(fileManager: FileManager = .default) {
        self.fileManager = fileManager
        print(filePath)
    }
    
    public func save(data: Data?, completion: @escaping (Result<String, FileStorageError>)-> Void) {
        guard let data else {
            completion(.failure(.emptyData))
            return
        }
        
        var imageData = data
        var fileExtension = "heic" // 기본적으로 HEIF로 저장
        
        // 1️⃣ PNG 데이터인지 확인 후 HEIF로 변환
        if isPNG(data: data), let convertedData = convertPNGToHEIF(data: data) {
            imageData = convertedData
        } else if isPNG(data: data) {
            completion(.failure(.convertError))
            return
        }
        
        // 2️⃣ 파일명 생성 (정렬 가능 + 고유성 유지)
        let timestamp = Int(Date().timeIntervalSince1970)  // 유닉스 타임스탬프
        let shortUUID = UUID().uuidString.prefix(8)       // UUID 앞 8자리
        let filename = "IMG_\(timestamp)_\(shortUUID).\(fileExtension)"
        
        let fileURL = filePath.appendingPathComponent(filename)
        
        // 3️⃣ 데이터 저장
        do {
            try imageData.write(to: fileURL)
            completion(.success(fileURL.path))  // 저장 성공 시 경로 반환
        } catch {
            completion(.failure(.saveError(error)))  // 저장 실패 처리
        }
    }
    
    // 📌 PNG인지 확인하는 함수
    private func isPNG(data: Data) -> Bool {
        return data.starts(with: [0x89, 0x50, 0x4E, 0x47]) // PNG 파일 헤더 체크
    }
    
    // 📌 PNG → HEIF 변환 함수
    private func convertPNGToHEIF(data: Data) -> Data? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil),
              let cgImage = CGImageSourceCreateImageAtIndex(source, 0, nil) else {
            return nil
        }
        
        let imageDestinationData = NSMutableData()
        guard let imageDestination = CGImageDestinationCreateWithData(imageDestinationData, AVFileType.heic as CFString, 1, nil) else {
            return nil
        }
        
        let options: [CFString: Any] = [
            kCGImageDestinationLossyCompressionQuality: 0.8 // 압축 품질 (0.0 ~ 1.0)
        ]
        
        CGImageDestinationAddImage(imageDestination, cgImage, options as CFDictionary)
        CGImageDestinationFinalize(imageDestination)
        
        return imageDestinationData as Data
    }
}
