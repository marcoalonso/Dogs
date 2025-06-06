//
//  GetDogsUseCase.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

protocol GetDogsUseCaseProtocol {
    func execute() async throws -> [Dog]
}

final class GetDogsUseCase: GetDogsUseCaseProtocol {
    private let repository: DogRepositoryProtocol

    init(repository: DogRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> [Dog] {
        try await repository.fetchDogs()
    }
}

final class MockGetDogsUseCase: GetDogsUseCaseProtocol {
    func execute() async throws -> [Dog] {
        return Dog.mockList
    }
}
