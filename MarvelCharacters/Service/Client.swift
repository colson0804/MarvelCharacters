//
//  Client.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import Foundation

final class Client {
    static let shared = Client()
    private init() {}
    
    func sendRequest<T: Decodable>(url: URL, responseModel: T.Type) async -> Result<T, ApiError> {
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard let response = response as? HTTPURLResponse else {
                return .failure(.emptyResults)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.parsingError)
                }
                
                return .success(decodedResponse)
            default:
                return .failure(.serverError(code: response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
