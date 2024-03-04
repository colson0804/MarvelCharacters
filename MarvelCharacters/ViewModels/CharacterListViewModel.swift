//
//  CharacterListViewModel.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/2/24.
//

import SwiftUI

extension CharacterListView {
    class ViewModel: ObservableObject {
        @Published private(set) var characters: [Character] = []
        private let service: MarvelServiceProtocol
        private var currentPage = 0
        
        init(service: MarvelServiceProtocol = MarvelService()) {
            self.service = service
        }
        
        func fetchCharacters(isInitialFetch: Bool) {
            currentPage = isInitialFetch ? 0 : currentPage
            Task {
                let result = await service.getCharacters(pageOffset: currentPage)
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        if isInitialFetch {
                            self.characters = characters
                        } else {
                            self.characters.append(contentsOf: characters)
                        }
                    }
                    currentPage += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
