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
private let pageSize = 20

protocol MarvelServiceProtocol {
    func getCharacters(pageOffset: Int) async -> Result<[Character], ApiError>
    func getComics(for character: Character, pageOffset: Int) async -> Result<[Comic], ApiError>
}

struct MarvelService: MarvelServiceProtocol {
    func getCharacters(pageOffset: Int = 0) async -> Result<[Character], ApiError> {
        let endpoint = "\(baseUrl)v1/public/characters"
        guard let url = formattedUrl(from: endpoint, pageOffset: pageOffset) else {
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
    
    func getComics(for character: Character, pageOffset: Int = 0) async -> Result<[Comic], ApiError> {
        let endpoint = "\(baseUrl)v1/public/characters/\(character.id)/comics"
        guard let url = formattedUrl(from: endpoint, pageOffset: pageOffset) else {
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
    
    private func formattedUrl(from baseUrl: String, pageOffset: Int) -> URL? {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            return nil
        }
        
        let timestamp = String(Date().timeIntervalSince1970)
        let hash = (timestamp + privateKey + publicKey).md5
        let params = [
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "offset", value: String(pageOffset * pageSize)),
            URLQueryItem(name: "limit", value: String(pageSize))
        ]
        urlComponents.queryItems = params
        
        return urlComponents.url
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
