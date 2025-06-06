//
//  DogDTO.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

struct DogDTO: Codable {
    let dogName: String
    let description: String
    let age: Int
    let image: String
}
