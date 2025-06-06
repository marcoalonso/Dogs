//
//  Dog.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import Foundation

struct Dog: Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let age: Int
    let image: String
    
    init(id: String = UUID().uuidString, name: String, description: String, age: Int, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.age = age
        self.image = image
    }
}


extension Dog {
    static let mockList: [Dog] = [
        Dog(
            name: "Firulais",
            description: "Loves running in the park and chasing butterflies.",
            age: 2,
            image: "https://place-puppy.com/300x300"
        ),
        Dog(
            name: "Max",
            description: "Very loyal and always protects the family.",
            age: 5,
            image: "https://place-puppy.com/301x301"
        ),
        Dog(
            name: "Luna",
            description: "Playful and friendly with everyone she meets.",
            age: 3,
            image: "https://place-puppy.com/302x302"
        )
    ]
}
