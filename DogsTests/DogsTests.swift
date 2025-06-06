//
//  DogsTests.swift
//  DogsTests
//
//  Created by Marco Alonso Rodriguez on 06/06/25.
//

import XCTest
import CoreData
@testable import Dogs

final class DogListViewModelTests: XCTestCase {

    // MARK: - ViewModel Tests

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

    // MARK: - Core Data (DogLocalDataSource) Tests

    var inMemoryContext: NSManagedObjectContext!
    var dataSource: DogLocalDataSource!

    override func setUp() {
        super.setUp()

        let container = NSPersistentContainer(name: "DogsDB")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        container.persistentStoreDescriptions = [description]

        let expectation = self.expectation(description: "Load persistent stores")
        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)

        inMemoryContext = container.viewContext
        dataSource = DogLocalDataSource(context: inMemoryContext)
    }

    override func tearDown() {
        inMemoryContext = nil
        dataSource = nil
        super.tearDown()
    }

    func test_saveDogs_savesCorrectly() throws {
        let dogs = [
            DogDTO(dogName: "Fido", description: "Friendly dog", age: 3, image: "https://img.com/fido.jpg"),
            DogDTO(dogName: "Luna", description: "Smart dog", age: 5, image: "https://img.com/luna.jpg")
        ]

        try dataSource.saveDogs(dogs)

        let fetchRequest: NSFetchRequest<DogEntity> = DogEntity.fetchRequest()
        let savedDogs = try inMemoryContext.fetch(fetchRequest)

        XCTAssertEqual(savedDogs.count, 2)

        let savedNames = savedDogs.compactMap { $0.name }
        XCTAssertTrue(savedNames.contains("Fido"))
        XCTAssertTrue(savedNames.contains("Luna"))
    }

    func test_fetchDogs_returnsCorrectDTOs() throws {
        let entity = DogEntity(context: inMemoryContext)
        entity.name = "Max"
        entity.dogDescription = "Guardian"
        entity.age = 4
        entity.image = "https://img.com/max.jpg"
        try inMemoryContext.save()

        let result = try dataSource.fetchDogs()

        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.dogName, "Max")
        XCTAssertEqual(result.first?.description, "Guardian")
        XCTAssertEqual(result.first?.age, 4)
        XCTAssertEqual(result.first?.image, "https://img.com/max.jpg")
    }
}
