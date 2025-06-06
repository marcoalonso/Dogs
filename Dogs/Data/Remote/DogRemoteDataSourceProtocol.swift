//
//  DogRemoteDataSourceProtocol.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

protocol DogRemoteDataSourceProtocol {
    func fetchDogs() async throws -> [DogDTO]
}
