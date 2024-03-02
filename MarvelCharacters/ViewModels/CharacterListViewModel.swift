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
        private let service = MarvelService()
        private var currentPage = 0
        
        func fetchCharacters() {
            Task {
                let result = await service.getCharacters()
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self.characters = characters
                    }
                    currentPage += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func fetchNextPage() {
            Task {
                let result = await service.getCharacters(pageOffset: currentPage)
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self.characters.append(contentsOf: characters)
                    }
                    currentPage += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
