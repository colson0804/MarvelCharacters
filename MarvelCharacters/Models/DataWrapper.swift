//
//  DataWrapper.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

struct DataWrapper<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: DataContainer<T>
}

struct DataContainer<T: Decodable>: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}
