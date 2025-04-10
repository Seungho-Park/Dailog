//
//  NewDiaryCoreDataStorage.swift
//  CoreStorage
//
//  Created by 박승호 on 4/3/25.
//  Copyright © 2025 DevLabs Co. All rights reserved.
//

import CoreStorageInterfaces
import CoreData

public final class NewDiaryCoreDataStorage: NewDiaryStorage {
    private let coreDataStorage: CoreDataStorage
    
    public init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
    
    public func fetchDiaries(
        year: Int?,
        month: Int?,
        page: Int,
        count: Int,
        completion: @escaping (Result<NewDiaryDTO, CoreDataStorageError>) -> Void
    ) {
        let fetchRequest: NSFetchRequest<DiaryEntity2> = DiaryEntity2.fetchRequest()
        
        fetchRequest.fetchLimit = count
        fetchRequest.fetchOffset = (page - 1) * count
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        if let year = year, let month = month {
            let calendar = Calendar.current
            let startOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: 1))!
            let rangeOfMonth = calendar.range(of: .day, in: .month, for: startOfMonth)!
            let endOfMonth = calendar.date(from: DateComponents(year: year, month: month, day: rangeOfMonth.count))!
            
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfMonth as CVarArg, endOfMonth as CVarArg)
        } else if let year = year {
            let calendar = Calendar.current
            let startOfYear = calendar.date(from: DateComponents(year: year, month: 1, day: 1))!
            let endOfYear = calendar.date(from: DateComponents(year: year, month: 12, day: 31))!
            
            fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date <= %@", startOfYear as CVarArg, endOfYear as CVarArg)
        }
        
        coreDataStorage.performBackgroundTask { context in
            do {
                let totalCountRequest: NSFetchRequest<DiaryEntity2> = DiaryEntity2.fetchRequest()
                totalCountRequest.predicate = fetchRequest.predicate
                
                let totalCount = try context.count(for: totalCountRequest)
                let totalPages = count == 0 ? 1 : Int(ceil(Double(totalCount) / Double(count)))
                
                let diaries = try context.fetch(fetchRequest)
                completion(.success(.init(currentPage: page <= 0 ? 1 : page, totalPage: totalPages, count: diaries.count, diaries: diaries.map { $0.toDTO() })))
            } catch {
                completion(.failure(.fetchError(error)))
            }
        }
    }
    
    public func saveDiary(
        diary: CoreStorageInterfaces.NewDiaryDTO.DiaryEntity,
        completion: @escaping (Result<NewDiaryDTO.DiaryEntity, CoreDataStorageError>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<DiaryEntity2> = DiaryEntity2.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", diary.id as CVarArg)
            
            do {
                let results = try context.fetch(fetchRequest)
                let diaryEntity = results.first ?? DiaryEntity2(context: context)
                
                diaryEntity.id = diary.id
                diaryEntity.createdAt = diary.createdAt
                diaryEntity.updatedAt = Date()
                                
                if let existingContents = diaryEntity.contents as? Set<DiaryContentEntity> {
                    existingContents.forEach {
                        if let photo = $0.photo {
                            context.delete(photo)
                        }
                        
                        context.delete($0)
                    }
                }
                
                let newContents = diary.contents.map { contentDTO -> DiaryContentEntity in
                    let contentEntity = DiaryContentEntity(context: context)
                    contentEntity.id = contentDTO.id
                    contentEntity.orderIdx = Int16(contentDTO.orderIdx)
                    contentEntity.text = contentDTO.text
                    contentEntity.type = contentDTO.type
                    contentEntity.diary = diaryEntity
                    
                    if let photoDTO = contentDTO.photo {
                        let photoEntity = PhotoEntity2(context: context)
                        photoEntity.fileName = photoDTO.fileName
                        photoEntity.memo = photoDTO.memo
                        photoEntity.createdAt = photoDTO.createdAt
                        photoEntity.width = photoDTO.width
                        photoEntity.content = contentEntity
                        
                        contentEntity.photo = photoEntity
                    }
                    
                    return contentEntity
                }
                
                diaryEntity.contents = NSSet(array: newContents)
                
                if let thumbnail = diary.thumbnail {
                    let thumbnailContents = newContents.first(where: { $0.id == thumbnail.id })
                    thumbnailContents?.thumbnail = diaryEntity
                    diaryEntity.thumbnail = thumbnailContents
                } else {
                    diaryEntity.thumbnail = nil
                }
                
                try context.save()
                completion(.success(diary))
            } catch {
                context.rollback()
                completion(.failure(.saveError(error)))
            }
        }
    }
    
    public func deleteDiary(
        id: UUID,
        completion: @escaping (Result<NewDiaryDTO.DiaryEntity, CoreDataStorageError>) -> Void
    ) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<DiaryEntity2> = DiaryEntity2.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
            
            do {
                if let entity = try context.fetch(fetchRequest).first {
                    let dto = entity.toDTO()
                    context.delete(entity)
                    try context.save()
                    completion(.success(dto))
                } else {
                    completion(.failure(.removeError(NSError(domain: "DiaryCoreDataStorage", code: 404, userInfo: [NSLocalizedDescriptionKey: "해당 다이어리를 찾을 수 없습니다."]))))
                }
            } catch {
                completion(.failure(.removeError(error)))
            }
        }
    }
}

private extension DiaryEntity2 {
    func toDTO()-> NewDiaryDTO.DiaryEntity {
        return .init(id: id!, emotion: emotion, contents: (contents as? Set<DiaryContentEntity>)?.map { $0.toDTO() } ?? [], thumbnail: thumbnail?.toDTO(), date: date!, createdAt: createdAt!, updatedAt: updatedAt!)
    }
}

private extension DiaryContentEntity {
    func toDTO()-> DiaryContentDTO {
        return .init(id: id!, type: type!, text: text!, orderIdx: Int(orderIdx), photo: photo?.toDTO())
    }
}

private extension PhotoEntity2 {
    func toDTO()-> PhotoDTO {
        return .init(fileName: fileName!, memo: memo!, width: width, createdAt: createdAt!)
    }
}
