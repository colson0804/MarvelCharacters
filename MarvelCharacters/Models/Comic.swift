//
//  Comic.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

struct Comic: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let issueNumber: Double
    let description: String
    let thumbnail: Thumbnail
}
