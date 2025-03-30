//
//  DiaryCoreDataStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 3/25/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreStorageInterfaces
import CoreData

public final class DiaryCoreDataStorage: DiaryStorage {
    private let coreDataStorage: CoreDataStorage
    
    public init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    public func fetchDiaries(year: Int?, month: Int?, page: Int, count: Int, completion: @escaping (Result<DiaryStorageDTO, CoreDataStorageError>)-> Void) {
        // FetchRequest 설정
        let fetchRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
        
        // 페이징 처리: 가져올 항목의 수와 건너뛸 항목의 수를 설정
        fetchRequest.fetchLimit = count
        fetchRequest.fetchOffset = (page - 1) * count
        
        // 정렬 조건 (예: 날짜 기준 내림차순)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        // 필터링 조건 설정
        if let year = year, let month = month {
            // 년도와 월로 필터링
            let calendar = Calendar.current
            let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
            let rangeOfMonth = calendar.range(of: .day, in: .month, for: startOfMonth)!
            let endOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: rangeOfMonth.count))!
            
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfMonth as CVarArg, endOfMonth as CVarArg)
        } else if let year = year {
            // 년도로만 필터링
            let calendar = Calendar.current
            let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
            let endOfYear = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
            
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfYear as CVarArg, endOfYear as CVarArg)
        } else {
            // 전체 데이터를 필터링하지 않고 페이징 처리
            fetchRequest.predicate = nil
        }
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let totalCountRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
                totalCountRequest.predicate = fetchRequest.predicate
                totalCountRequest.includesSubentities = false
                        
                let totalCount = try context.count(for: totalCountRequest)
                let totalPages = count == 0 ? 1 : Int(ceil(Double(totalCount) / Double(count)))
                
                let diaries = try context.fetch(fetchRequest)
                completion(.success(.init(currentPage: page <= 0 ? 1 : page, totalPage: totalPages, diaries: diaries.map { $0.toDTO() })))
            } catch {
                completion(.failure(.fetchError(error)))
            }
        }
    }
    
    public func save(diary: DiaryStorageDTO.DiaryItem, completion: @escaping (Result<DiaryStorageDTO.DiaryItem, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", diary.id as CVarArg)
            
            do {
                let existingDiary = try context.fetch(fetchRequest).first
                let diaryEntity = existingDiary ?? DiaryEntity(context: context)
                
                // 공통 속성 업데이트
                diaryEntity.id = diary.id
                diaryEntity.emotion = diary.emotion ?? -1
                diaryEntity.contents = diary.contents
                diaryEntity.date = diary.date
                diaryEntity.createdAt = diary.createdAt
                diaryEntity.updatedAt = diary.updatedAt
                
                // 📌 기존 사진 목록 가져오기
                let existingPhotos = diaryEntity.photos as? Set<PhotoEntity> ?? []
                let existingPhotoMap = Dictionary(uniqueKeysWithValues: existingPhotos.map { ($0.fileName, $0) })
                
                // 📌 새로운 사진 ID 목록 생성
                let newPhotoFileNames = Set(diary.photos.map { $0.fileName })
                
                // 📌 기존 사진 중 삭제된 사진을 찾고 삭제
                existingPhotos.forEach { photo in
                    if !newPhotoFileNames.contains(photo.fileName!) {
                        context.delete(photo)
                    }
                }
                
                // 📌 사진 추가 및 업데이트
                diary.photos.forEach { photoDTO in
                    if let existingPhoto = existingPhotoMap[photoDTO.fileName] {
                        existingPhoto.memo = photoDTO.memo
                        existingPhoto.createdAt = photoDTO.createdAt
                    } else {
                        let newPhotoEntity = PhotoEntity(entity: photoDTO, insertInto: context)
                        diaryEntity.addToPhotos(newPhotoEntity)
                    }
                }
                
                try context.save()
                completion(.success(diaryEntity.toDTO()))
            } catch {
                completion(.failure(.saveError(error)))
            }
        }
    }
    
    public func remove(diary: DiaryStorageDTO.DiaryItem, completion: @escaping (Result<DiaryStorageDTO.DiaryItem, CoreDataStorageError>)-> Void) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", diary.id as CVarArg)
            
            do {
                if let entity = try context.fetch(fetchRequest).first {
                    context.delete(entity)
                    try context.save()
                    completion(.success(diary))
                } else {
                    completion(.failure(.removeError(NSError(domain: "DiaryCoreDataStorage", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 다이어리를 찾을 수 없습니다."]))))
                }
            } catch {
                completion(.failure(.removeError(error)))
            }
        }
    }
}

public extension DiaryEntity {
    convenience init(entity: DiaryStorageDTO.DiaryItem, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = entity.id
        self.contents = entity.contents
        self.emotion = entity.emotion ?? -1
        self.createdAt = entity.createdAt
        self.updatedAt = entity.updatedAt
        self.date = entity.date
    }
    
    func toDTO()-> DiaryStorageDTO.DiaryItem {
        let photoDTOs = (self.photos as? Set<PhotoEntity>)?.map { $0.toDTO() }.sorted(by: { lhs, rhs in
            lhs.createdAt < rhs.createdAt
        }) ?? []
        
        return .init(id: self.id!, emotion: self.emotion, contents: self.contents!, date: self.date!, photos: photoDTOs, createdAt: self.createdAt!, updatedAt: self.updatedAt!)
    }
}

public extension PhotoEntity {
    convenience  init(entity: PhotoStorageDTO, insertInto context: NSManagedObjectContext) {
        self.init(context: context)
        self.fileName = entity.fileName
        self.memo = entity.memo
        self.createdAt = entity.createdAt
    }
    
    func toDTO() -> PhotoStorageDTO {
        return .init(fileName: self.fileName!, memo: self.memo!, createdAt: self.createdAt!)
    }
}
