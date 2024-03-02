//
//  MarvelService.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import CommonCrypto
import Foundation

// NOTE: These should not be stored on the client. Ideally they should be stored on a personal server which
// will serve as an intermediary with the Marvel API
private let publicKey = "fd9a8956c9379668d8a84f13c490752c"
private let privateKey = "7cfbfdb18234d0ea4fd43fd2a3749041d65e7069"
private let baseUrl = "https://gateway.marvel.com/"

struct MarvelService {
    func getCharacters() async -> Result<[Character], ApiError> {
        let endpoint = "\(baseUrl)v1/public/characters"
        guard let url = formattedUrl(from: endpoint) else {
            return .failure(.invalidUrl)
        }
        
        let result = await Client.shared.sendRequest(url: url, responseModel: DataWrapper<Character>.self)
        switch result {
        case .success(let dataWrapper):
            return .success(dataWrapper.data.results)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getComics(for character: Character) async -> Result<[Comic], ApiError> {
        let endpoint = "\(baseUrl)v1/public/characters/\(character.id)/comics"
        guard let url = formattedUrl(from: endpoint) else {
            return .failure(.invalidUrl)
        }
        
        let result = await Client.shared.sendRequest(url: url, responseModel: DataWrapper<Comic>.self)
        switch result {
        case .success(let dataWrapper):
            return .success(dataWrapper.data.results)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func formattedUrl(from baseUrl: String) -> URL? {
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = (timestamp + privateKey + publicKey).md5
        let params = "apikey=\(publicKey)&ts=\(timestamp)&hash=\(hash)"
        return URL(string: "\(baseUrl)?\(params)")
    }
}

// Extension to compute MD5 hash
private extension String {
    var md5: String {
        let data = data(using: .utf8)!
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        _ = data.withUnsafeBytes { dataBytes in
            CC_MD5(dataBytes.baseAddress, CC_LONG(data.count), &digest)
        }
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
