//
//  DogRepositoryProtocol.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

protocol DogRepositoryProtocol {
    func fetchDogs() async throws -> [Dog]
}
