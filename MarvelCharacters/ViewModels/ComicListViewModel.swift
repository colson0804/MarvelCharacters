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
        private let service = MarvelService()
        private var currentPage = 0
        
        init(character: Character) {
            self.selectedCharacter = character
        }
        
        func fetchComics() {
            Task {
                let result = await service.getComics(for: selectedCharacter)
                switch result {
                case .success(let comics):
                    DispatchQueue.main.async {
                        self.comics = comics
                    }
                    currentPage += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        func fetchNextPage() {
            Task {
                let result = await service.getComics(for: selectedCharacter, pageOffset: currentPage)
                switch result {
                case .success(let comics):
                    DispatchQueue.main.async {
                        self.comics.append(contentsOf: comics)
                    }
                    currentPage += 1
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
