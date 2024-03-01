//
//  Character.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

struct Character: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
