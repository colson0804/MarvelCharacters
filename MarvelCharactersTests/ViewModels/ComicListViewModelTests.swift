//
//  ComicListViewModelTests.swift
//  MarvelCharactersTests
//
//  Created by Craig Olson on 3/3/24.
//

import XCTest
@testable import MarvelCharacters

final class ComicListViewModelTests: XCTestCase {
    private var sut: ComicListView.ViewModel!
    private var mockService: MockMarvelService!
    
    override func setUp() {
        super.setUp()
        let character = Character(id: 1, name: "Black Widow", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        mockService = MockMarvelService()
        sut = ComicListView.ViewModel(service: mockService, character: character)
    }
    
    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchComicsSuccess() {
        let comics = [
            Comic(id: 1, title: "Comic 1", issueNumber: 1, description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Comic(id: 2, title: "Comic 2", issueNumber: 2, description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        
        mockService.getComicsResult = .success(comics)
        
        sut.fetchComics(isInitialFetch: true)
        
        let expectation = XCTestExpectation(description: "Characters fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.comics, comics)
            XCTAssertEqual(self.mockService.comicPageOffset, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testFetchComicsNextPageSuccess() {
        let pageOneComics = [
            Comic(id: 1, title: "Comic 1", issueNumber: 1, description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Comic(id: 2, title: "Comic 2", issueNumber: 2, description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        let pageTwoComics = [
            Comic(id: 3, title: "Comic 3", issueNumber: 3, description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
            Comic(id: 4, title: "Comic 4", issueNumber: 4, description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
        ]
        
        mockService.getComicsResult = .success(pageOneComics)
        
        sut.fetchComics(isInitialFetch: true)
        
        let pageOneExpectation = XCTestExpectation(description: "Comics fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.comics, pageOneComics)
            XCTAssertEqual(self.mockService.comicPageOffset, 0)
            pageOneExpectation.fulfill()
        }
        wait(for: [pageOneExpectation], timeout: 5)
        
        mockService.getComicsResult = .success(pageTwoComics)
        
        sut.fetchComics(isInitialFetch: false)
        
        let pageTwoExpectation = XCTestExpectation(description: "Comics fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.sut.comics, pageOneComics + pageTwoComics)
            XCTAssertEqual(self.mockService.comicPageOffset, 1)
            pageTwoExpectation.fulfill()
        }
        wait(for: [pageTwoExpectation], timeout: 5)
    }
    
    func testFetchComicsFailure() {
        mockService.getCharactersResult = .failure(.unauthorized)
        
        sut.fetchComics(isInitialFetch: true)
        
        let expectation = XCTestExpectation(description: "Comics fetched successfully")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertTrue(self.sut.comics.isEmpty)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
}
