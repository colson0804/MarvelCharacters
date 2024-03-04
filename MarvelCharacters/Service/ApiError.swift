//
//  ApiError.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/3/24.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case parsingError
    case unauthorized
    case emptyResults
    case serverError(code: Int)
    case unknown
}
