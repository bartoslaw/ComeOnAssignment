//
//  GameListViewModelTests.swift
//  ComeOn AssignmentTests
//
//  Created by Bartłomiej Smektała on 23/06/2022.
//

import XCTest
import Combine
@testable import ComeOn_Assignment

class GameListViewModelTests: XCTestCase {
    private let timeout = 5.0
    
    var bag: Set<AnyCancellable> = Set()
    
    var apiClient: MockAPIClient?
    var gamesListRepository: GamesListRepositoryProtocol?
    var getGamesListUseCase: GetGamesListUseCase?
    
    override func setUpWithError() throws {
        self.apiClient = MockAPIClient()
        self.gamesListRepository = GamesListRepostiory(remoteSource: self.apiClient!)
        self.getGamesListUseCase = GetGamesListUseCase(gamesRepository: self.gamesListRepository!)
        
        self.bag = []
    }
    
    func testInitialStateCorrect() throws {
        let vm = GamesListViewModel(getGamesListUseCase: self.getGamesListUseCase!)
        
        XCTAssertTrue(vm.state == .initial, "Initial state is not correct")
    }
    
    func testCorrectStateWhenViewAppears() throws {
        let vm = GamesListViewModel(getGamesListUseCase: self.getGamesListUseCase!)
        
        vm.onAppear()
        
        XCTAssert(vm.state == .loading, "View Model not loading after view appears")
    }
    
    func testCorrectStateIsSetWhenDataObtained() throws {
        let expectation = XCTestExpectation(description: "Receive result state and then finished state")
        
        let vm = GamesListViewModel(getGamesListUseCase: self.getGamesListUseCase!)
        
        vm.onAppear()
        
        vm.$state
            .dropFirst(2)//drop initial and loading
            .sink(receiveValue: { _ in
                XCTAssert(vm.state == .result)
                expectation.fulfill()
            })
            .store(in: &bag)
        
        wait(for: [expectation], timeout: self.timeout)
        
        XCTAssert(vm.state == .finished)
    }
    
    func testErrorStateWhenDataIsNotObtained() throws {
        let expectation = XCTestExpectation(description: "Receive error state when api does not return correct response")
        
        self.apiClient?.shouldReturnError = true
        
        let vm = GamesListViewModel(getGamesListUseCase: self.getGamesListUseCase!)
        
        var value: ViewModelState = .initial
        
        vm.onAppear()
        
        vm.$state
            .dropFirst(1)
            .sink { _ in
            } receiveValue: { val in
                value = val
                expectation.fulfill()
            }
            .store(in: &bag)
        
        wait(for: [expectation], timeout: self.timeout)
        
        XCTAssert(value == .error)
    }
    
    func testTotalNumberOfGamesOnSuccess() throws {
        let expectation = XCTestExpectation(description: "Total number of games > 0 on success")
            
        let vm = GamesListViewModel(getGamesListUseCase: self.getGamesListUseCase!)
        
        vm.onAppear()
        
        vm.$totalAmountOfGames
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &bag)
        
        wait(for: [expectation], timeout: self.timeout)
        
        XCTAssert(vm.totalAmountOfGames > 0, "Total number of games is not > 0")
    }
}
