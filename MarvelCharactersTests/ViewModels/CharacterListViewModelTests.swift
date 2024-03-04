//
//  CharacterListViewModelTests.swift
//  MarvelCharactersTests
//
//  Created by Craig Olson on 3/3/24.
//

import XCTest
@testable import MarvelCharacters

final class CharacterListViewModelTests: XCTestCase {
    private var sut: CharacterListView.ViewModel!
    private var mockService: MockMarvelService!
    
    override func setUp() {
        super.setUp()
        mockService = MockMarvelService()
        sut = CharacterListView.ViewModel(service: mockService)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchCharactersSuccess() {
        let characters = [
            Character(id: 1, name: "Character 1", description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Character(id: 2, name: "Character 2", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        
        mockService.getCharactersResult = .success(characters)
        
        sut.fetchCharacters()
        
        let expectation = XCTestExpectation(description: "Characters fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.characters, characters)
            XCTAssertEqual(self.mockService.characterPageOffset, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchCharactersNextPageSuccess() {
        let pageOneCharacters = [
            Character(id: 1, name: "Character 1", description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Character(id: 2, name: "Character 2", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        let pageTwoCharacters = [
            Character(id: 3, name: "Character 3", description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Character(id: 4, name: "Character 4", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        
        mockService.getCharactersResult = .success(pageOneCharacters)
        
        sut.fetchCharacters(isInitialFetch: true)
        
        let pageOneExpectation = XCTestExpectation(description: "Characters fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.characters, pageOneCharacters)
            XCTAssertEqual(self.mockService.characterPageOffset, 0)
            pageOneExpectation.fulfill()
        }
        wait(for: [pageOneExpectation], timeout: 5)
        
        mockService.getCharactersResult = .success(pageTwoCharacters)
        
        sut.fetchCharacters(isInitialFetch: false)
        
        let pageTwoExpectation = XCTestExpectation(description: "Characters fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.characters, pageOneCharacters + pageTwoCharacters)
            XCTAssertEqual(self.mockService.characterPageOffset, 1)
            pageTwoExpectation.fulfill()
        }
        wait(for: [pageTwoExpectation], timeout: 5)
    }
    
    func testFetchCharactersFailure() {
        mockService.getCharactersResult = .failure(.unauthorized)
        
        sut.fetchCharacters()
        
        let expectation = XCTestExpectation(description: "Characters fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.sut.characters.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
