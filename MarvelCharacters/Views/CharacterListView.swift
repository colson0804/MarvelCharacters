//
//  CharacterListView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                Text("Popular Characters")
                    .foregroundStyle(.white)
                ListView(items: viewModel.characters) { character in
                    NavigationLink(destination: {
                        ComicListView(character: character)
                    }, label: {
                        CharacterView(character: character)
                    })
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchCharacters()
            }
        }
    }
}

#Preview {
    return CharacterListView()
}
