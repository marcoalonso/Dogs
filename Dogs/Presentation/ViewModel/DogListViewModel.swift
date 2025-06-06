//
//  DogListViewModel.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

@MainActor
final class DogListViewModel: ObservableObject {
    @Published var dogs: [Dog] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getDogsUseCase: GetDogsUseCaseProtocol

    init(getDogsUseCase: GetDogsUseCaseProtocol) {
        self.getDogsUseCase = getDogsUseCase
    }

    func fetchDogs() async {
        isLoading = true
        errorMessage = nil
        do {
            dogs = try await getDogsUseCase.execute()
        } catch {
            errorMessage = "Failed to load dogs: \(error.localizedDescription)"
        }
        isLoading = false
    }
}

