//
//  MockMarvelService.swift
//  MarvelCharactersTests
//
//  Created by Craig Olson on 3/3/24.
//

@testable import MarvelCharacters

final class MockMarvelService: MarvelServiceProtocol {
    var getCharactersResult: Result<[Character], ApiError> = .failure(.emptyResults)
    var getComicsResult: Result<[Comic], ApiError> = .failure(.emptyResults)
    
    var characterPageOffset = 0
    var comicPageOffset = 0
    
    func getCharacters(pageOffset: Int) async -> Result<[Character], ApiError> {
        characterPageOffset = pageOffset
        return getCharactersResult
    }
    
    func getComics(for character: Character, pageOffset: Int) async -> Result<[Comic], ApiError> {
        comicPageOffset = pageOffset
        return getComicsResult
    }
    
    
}
