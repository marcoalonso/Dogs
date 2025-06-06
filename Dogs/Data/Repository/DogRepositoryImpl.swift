//
//  DogRepositoryImpl.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

final class DogRepositoryImpl: DogRepositoryProtocol {
    private let remoteDataSource: DogRemoteDataSourceProtocol
    private let localDataSource: DogLocalDataSourceProtocol

    init(
        remoteDataSource: DogRemoteDataSourceProtocol,
        localDataSource: DogLocalDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func fetchDogs() async throws -> [Dog] {
        do {
            let localDTOs = try localDataSource.fetchDogs()
            if !localDTOs.isEmpty {
                print("Loaded dogs from Core Data \(localDTOs)")
                return DogMapper.mapList(from: localDTOs)
            }
        } catch {
            print("Error reading from Core Data: \(error)")
        }
        
        let remoteDTOs = try await remoteDataSource.fetchDogs()

        do {
            try localDataSource.saveDogs(remoteDTOs)
            print("Saved dogs to Core Data")
        } catch {
            print("Error saving to Core Data: \(error)")
        }

        return DogMapper.mapList(from: remoteDTOs)
    }
}
