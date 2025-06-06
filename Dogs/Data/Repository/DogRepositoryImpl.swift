//
//  DogRepositoryImpl.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

final class DogRepositoryImpl: DogRepositoryProtocol {
    private let remoteDataSource: DogRemoteDataSourceProtocol

    init(remoteDataSource: DogRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchDogs() async throws -> [Dog] {
        let dogDTOs = try await remoteDataSource.fetchDogs()
        return DogMapper.mapList(from: dogDTOs)
    }
}
