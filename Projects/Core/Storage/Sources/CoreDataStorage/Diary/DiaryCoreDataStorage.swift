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
        let fetchRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
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
        } else {
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
                completion(.success(.init(page: page <= 0 ? 1 : page, totalPage: totalPages, diaries: diaries.map { $0.toDTO() })))
            } catch {
                completion(.failure(.fetchError(error)))
            }
        }
    }

    public func save(diary: DiaryDTO, completion: @escaping (Result<DiaryDTO, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            let fetchRequest: NSFetchRequest<DiaryEntity> = DiaryEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", diary.id as CVarArg)

            do {
                let existingDiary = try context.fetch(fetchRequest).first
                let diaryEntity = existingDiary ?? DiaryEntity(context: context)

                diaryEntity.id = diary.id
                diaryEntity.emotion = diary.emotion
                diaryEntity.date = diary.date
                diaryEntity.createdAt = diary.createdAt
                diaryEntity.updatedAt = diary.updatedAt

                // Remove old contents if updating
                if let existingContents = diaryEntity.contents as? Set<DiaryContentEntity> {
                    existingContents.forEach { context.delete($0) }
                }

                // Add new contents
                diary.contents.forEach { contentDTO in
                    let contentEntity = DiaryContentEntity(context: context)
                    contentEntity.id = contentDTO.id
                    contentEntity.type = contentDTO.type
                    contentEntity.orderIdx = Int64(contentDTO.orderIdx)
                    contentEntity.text = contentDTO.text
                    contentEntity.diary = diaryEntity

                    if let photoDTO = contentDTO.image {
                        let photoEntity = DiaryPhotoEntity(context: context)
                        photoEntity.id = photoDTO.id
                        photoEntity.path = photoDTO.path
                        photoEntity.width = photoDTO.width
                        photoEntity.height = photoDTO.height
                        photoEntity.content = contentEntity
                        contentEntity.image = photoEntity
                    }
                }

                try context.save()
                completion(.success(diary))
            } catch {
                completion(.failure(.saveError(error)))
            }
        }
    }

    public func remove(diary: DiaryDTO, completion: @escaping (Result<DiaryDTO, CoreDataStorageError>)-> Void) {
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
    func toDTO() -> DiaryDTO {
        let sortedContents = (contents as? Set<DiaryContentEntity>)?
            .sorted(by: { $0.orderIdx < $1.orderIdx })
            .map { $0.toDTO() } ?? []
        
        return DiaryDTO(
            id: id ?? UUID(),
            emotion: emotion,
            contents: sortedContents,
            date: date ?? Date(),
            createdAt: createdAt ?? Date(),
            updatedAt: updatedAt ?? Date()
        )
    }
}

public extension DiaryContentEntity {
    func toDTO() -> DiaryContentDTO {
        return DiaryContentDTO(
            id: id ?? UUID(),
            type: type ?? "Unknown",
            orderIdx: Int(orderIdx),
            text: text,
            image: image?.toDTO()
        )
    }
}

public extension DiaryPhotoEntity {
    func toDTO() -> DiaryPhotoDTO {
        return DiaryPhotoDTO(
            id: id ?? UUID(),
            path: path ?? "",
            width: width,
            height: height
        )
    }
}
