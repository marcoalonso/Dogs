//
//  DogsTests.swift
//  DogsTests
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import XCTest
@testable import Dogs

final class DogListViewModelTests: XCTestCase {

    func testSuccessfulFetchDogs() async {
        let mockDogs = Dog.mockList
        let mockRepo = MockDogRepository(result: .success(mockDogs))
        let useCase = GetDogsUseCase(repository: mockRepo)
        let viewModel = await DogListViewModel(getDogsUseCase: useCase)

        await viewModel.fetchDogs()

        await MainActor.run {
            XCTAssertEqual(viewModel.dogs.count, mockDogs.count)
            XCTAssertNil(viewModel.errorMessage)
        }
    }

    func testFailedFetchDogs() async {
        let error = NSError(domain: "Test", code: 0)
        let mockRepo = MockDogRepository(result: .failure(error))
        let useCase = GetDogsUseCase(repository: mockRepo)
        let viewModel = await DogListViewModel(getDogsUseCase: useCase)

        await viewModel.fetchDogs()

        await MainActor.run {
            XCTAssertTrue(viewModel.dogs.isEmpty)
            XCTAssertNotNil(viewModel.errorMessage)
        }
    }

    func testInitialState() async {
        let mockRepo = MockDogRepository(result: .success([]))
        let useCase = GetDogsUseCase(repository: mockRepo)
        let viewModel = await DogListViewModel(getDogsUseCase: useCase)

        await MainActor.run {
            XCTAssertTrue(viewModel.dogs.isEmpty)
            XCTAssertNil(viewModel.errorMessage)
            XCTAssertFalse(viewModel.isLoading)
        }
    }

    func testLoadingStateDuringFetch() async {
        let mockDogs = Dog.mockList
        let mockRepo = MockDogRepository(result: .success(mockDogs))
        let useCase = GetDogsUseCase(repository: mockRepo)
        let viewModel = await DogListViewModel(getDogsUseCase: useCase)

        await viewModel.fetchDogs()

        await MainActor.run {
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.dogs.count, mockDogs.count)
        }
    }

    func testErrorMessageResetOnNewFetch() async {
        let error = NSError(domain: "Test", code: 0)
        let mockRepo = MockDogRepository(result: .failure(error))
        let useCase = GetDogsUseCase(repository: mockRepo)
        let viewModel = await DogListViewModel(getDogsUseCase: useCase)

        await viewModel.fetchDogs()

        await MainActor.run {
            XCTAssertNotNil(viewModel.errorMessage)
        }

        let mockRepo2 = MockDogRepository(result: .success(Dog.mockList))
        let useCase2 = GetDogsUseCase(repository: mockRepo2)
        let newViewModel = await DogListViewModel(getDogsUseCase: useCase2)

        await newViewModel.fetchDogs()

        await MainActor.run {
            XCTAssertNil(newViewModel.errorMessage)
        }
    }
}
