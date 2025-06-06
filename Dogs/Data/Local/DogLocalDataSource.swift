//
//  DogLocalDataSource.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation
import CoreData

protocol DogLocalDataSourceProtocol {
    func saveDogs(_ dogs: [DogDTO]) throws
    func fetchDogs() throws -> [DogDTO]
}

final class DogLocalDataSource: DogLocalDataSourceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
    }

    func saveDogs(_ dogs: [DogDTO]) throws {
        for dto in dogs {
            let entity = DogEntity(context: context)
            entity.name = dto.dogName
            entity.dogDescription = dto.description
            entity.image = dto.image
            entity.age = Int16(dto.age)
        }
        
        try context.save()
    }

    func fetchDogs() throws -> [DogDTO] {
        let request: NSFetchRequest<DogEntity> = DogEntity.fetchRequest()
        let results = try context.fetch(request)
        return results.map {
            DogDTO(
                dogName: $0.name ?? "",
                description: $0.dogDescription ?? "",
                age: Int($0.age),
                image: $0.image ?? ""
            )
        }
    }
}
