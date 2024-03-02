//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import SwiftUI

extension ContentView {
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

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Popular Characters")
                .foregroundStyle(.white)
            ListView(items: viewModel.characters)
        }
        .padding()
        .onAppear {
            viewModel.fetchCharacters()
        }
    }
}

#Preview {
    return ContentView()
}
