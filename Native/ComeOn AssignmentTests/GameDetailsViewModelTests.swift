//
//  GameDetailsViewModelTests.swift
//  ComeOn AssignmentTests
//
//  Created by Bartłomiej Smektała on 23/06/2022.
//

import XCTest
@testable import ComeOn_Assignment

class GameDetailsViewModelTests: XCTestCase {
    var games: [Game]?
    
    override func setUpWithError() throws {
        self.games = try! JSONDecoder().decode([Game].self, from: JSONLoader.loadJson(fileName: "gameslist")!)
    }

    func testInitializationWithNonNilGame() throws {
        let vm = GameDetailsViewModel(game: games?.first!)
        
        vm.onAppear()
        
        XCTAssert(vm.state == .finished)
        XCTAssertFalse(vm.title.isEmpty)
        XCTAssertFalse(vm.description.isEmpty)
        XCTAssertFalse(vm.themeColorHex.isEmpty)
    }
    
    func testInitializationWithNilGame() throws {
        let vm = GameDetailsViewModel(game: nil)
        
        vm.onAppear()
        
        XCTAssert(vm.state == .error)
        XCTAssertTrue(vm.title.isEmpty)
        XCTAssertTrue(vm.description.isEmpty)
        XCTAssertTrue(vm.themeColorHex.isEmpty)
    }
    
    func testCorrectRGBHexParse() throws {
        let vm = GameDetailsViewModel(game: games?.first!)
        
        vm.onAppear()
        
        let color = UIColor(hex: vm.themeColorHex)
        
        XCTAssertNotNil(color)
    }
    
    func testIncorrectRGBHexParse() throws {
        var game = games?.first!
        game?.theme = "RGB(123)"
        
        let vm = GameDetailsViewModel(game: game)
        
        vm.onAppear()
        
        let color = UIColor(hex: vm.themeColorHex)
        
        XCTAssertTrue(vm.themeColorHex.isEmpty)
        XCTAssertNil(color)
    }
    
    func testCorrectLengthButWrongValuesRGBHexParse() throws {
        var game = games?.first!
        game?.theme = "RGB(ZZZZZZ)"
        
        let vm = GameDetailsViewModel(game: game)
        
        vm.onAppear()
        
        let color = UIColor(hex: vm.themeColorHex)
        
        XCTAssertTrue(vm.themeColorHex.isEmpty)
        XCTAssertNil(color)
    }

}
