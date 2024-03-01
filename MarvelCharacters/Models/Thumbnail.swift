//
//  Thumbnail.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

import Foundation

struct Thumbnail: Decodable, Hashable {
    let path: String
    let `extension`: String
    
    var url: URL? {
        return URL(string: "\(path).\(`extension`)")
    }
}
