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
        
        init(character: Character) {
            self.selectedCharacter = character
        }
        
        func fetchComics() {
            Task {
                let result = await MarvelService().getComics(for: selectedCharacter)
                switch result {
                case .success(let comics):
                    DispatchQueue.main.async {
                        self.comics = comics
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
