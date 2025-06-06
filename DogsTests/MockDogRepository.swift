//
//  MockDogRepository.swift
//  DogsTests
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

@testable import Dogs

final class MockDogRepository: DogRepositoryProtocol {
    var result: Result<[Dog], Error>

    init(result: Result<[Dog], Error>) {
        self.result = result
    }

    func fetchDogs() async throws -> [Dog] {
        switch result {
        case .success(let dogs):
            return dogs
        case .failure(let error):
            throw error
        }
    }
}
