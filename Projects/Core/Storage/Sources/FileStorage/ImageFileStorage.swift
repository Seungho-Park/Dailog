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
        #if DEBUG
        print(filePath)
        #endif
    }
    
    public func save(data: Data?, completion: @escaping (Result<FileInfo, FileStorageError>)-> Void) {
        guard let data else {
            completion(.failure(.emptyData))
            return
        }
        
        var imageData = data
        let fileExtension = "heic" // 기본적으로 HEIF로 저장
        
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
            if !fileManager.fileExists(atPath: fileURL.path) {
                fileManager.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            }
                
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            fileHandle.seekToEndOfFile()  // 파일 끝으로 이동
            try fileHandle.write(contentsOf: imageData)  // 데이터 쓰기
            try fileHandle.synchronize()
            try fileHandle.close()
            
            completion(.success(FileInfo(fileName: filename, data: imageData)))
        } catch {
            completion(.failure(.saveError(error)))  // 저장 실패 처리
        }
    }
    
    public func fetch(fileName: String, completion: @escaping (Result<FileInfo, FileStorageError>) -> Void) {
        let filePath = filePath.appendingPathComponent(fileName)
        guard fileManager.fileExists(atPath: filePath.path(percentEncoded: false)) else {
            completion(.failure(.fileNotExist))
            return
        }
        
        do {
            var imageData = Data()
            let bufferSize = 1024 * 1024
            let fileHandle = try FileHandle(forReadingFrom: filePath)
            
            while let chunk = try fileHandle.read(upToCount: bufferSize) {
                if chunk.isEmpty { break }
                imageData.append(chunk)
            }
            
            try fileHandle.close()
            completion(.success(FileInfo(fileName: fileName, data: imageData)))
        } catch {
            completion(.failure(.fetchError(error)))
        }
    }
    
    public func remove(fileName: String, completion: @escaping (Result<Bool, FileStorageError>) -> Void) {
        let filePath = filePath.appendingPathComponent(fileName)
        
        do {
            try fileManager.removeItem(at: filePath)
            completion(.success(true))
        } catch {
            completion(.failure(.removeError(error)))
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
