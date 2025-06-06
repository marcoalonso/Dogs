//
//  DogMapper.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

struct DogMapper {
    static func map(from dto: DogDTO) -> Dog {
        return Dog(
            name: dto.dogName,
            description: dto.description,
            age: dto.age,
            image: dto.image
        )
    }

    static func mapList(from dtoList: [DogDTO]) -> [Dog] {
        return dtoList.map { map(from: $0) }
    }
}
