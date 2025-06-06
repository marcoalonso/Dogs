//
//  DogListView.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import SwiftUI

struct DogListView: View {
    @StateObject var viewModel: DogListViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    } else {
                        ForEach(viewModel.dogs) { dog in
                            DogCardView(dog: dog)
                        }
                    }
                }
                .padding()
            }
            .background(Color.background)
            .navigationTitle("Dogs We Love")
        }
        .task {
            await viewModel.fetchDogs()
        }
    }
}

#Preview {
    let mockUseCase = MockGetDogsUseCase()
    let viewModel = DogListViewModel(getDogsUseCase: mockUseCase)
    return DogListView(viewModel: viewModel)
}
