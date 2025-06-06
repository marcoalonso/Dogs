//
//  DogCardView.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import SwiftUI

struct DogCardView: View {
    let dog: Dog

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            AsyncImage(url: URL(string: dog.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 100, height: 140)
            .clipped()
            .cornerRadius(12)

            VStack(alignment: .leading, spacing: 8) {
                Text(dog.name)
                    .font(.headline)
                    .foregroundColor(.primaryText)

                Text(dog.description)
                    .font(.subheadline)
                    .foregroundColor(.secondaryText)
                    .lineLimit(3)

                Text("Almost \(dog.age) year\(dog.age == 1 ? "" : "s")")
                    .font(.caption)
                    .bold()
                    .foregroundColor(.primaryText)
            }

            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    DogCardView(dog: Dog.mockList[0])
}
