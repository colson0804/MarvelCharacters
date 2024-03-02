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
        
        func fetchCharacters() {
            Task {
                let result = await MarvelService().getCharacters()
                switch result {
                case .success(let characters):
                    DispatchQueue.main.async {
                        self.characters = characters
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
