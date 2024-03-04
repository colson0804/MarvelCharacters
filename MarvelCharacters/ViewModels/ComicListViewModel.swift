//
//  ComicListViewModel.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/2/24.
//

import SwiftUI

extension ComicListView {
    class ViewModel: ObservableObject {
        let selectedCharacter: Character
        @Published private(set) var comics: [Comic] = []
        private let service: MarvelServiceProtocol
        private var currentPage = 0
        
        init(service: MarvelServiceProtocol = MarvelService(), character: Character) {
            self.service = service
            self.selectedCharacter = character
        }
        
        func fetchComics(isInitialFetch: Bool = true) {
            Task {
                let result = await service.getComics(for: selectedCharacter, pageOffset: currentPage)
                switch result {
                case .success(let comics):
                    DispatchQueue.main.async {
                        if isInitialFetch {
                            self.comics = comics
                        } else {
                            self.comics.append(contentsOf: comics)
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
