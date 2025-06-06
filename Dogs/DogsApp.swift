//
//  DogsApp.swift
//  Dogs
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import SwiftUI

@main
struct DogsApp: App {
    var body: some Scene {
        WindowGroup {
            let remoteDataSource = DogRemoteDataSource()
            let localDataSource = DogLocalDataSource()
            let repository = DogRepositoryImpl(
                remoteDataSource: remoteDataSource,
                localDataSource: localDataSource
            )
            let useCase = GetDogsUseCase(repository: repository)
            let viewModel = DogListViewModel(getDogsUseCase: useCase)
            DogListView(viewModel: viewModel)
        }
    }
}
