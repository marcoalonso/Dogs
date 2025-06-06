//
//  DogRemoteDataSource.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

final class DogRemoteDataSource: DogRemoteDataSourceProtocol {
    private let urlString = "https://jsonblob.com/api/1151549092634943488"

    func fetchDogs() async throws -> [DogDTO] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([DogDTO].self, from: data)
    }
}
