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
                HStack {
                    Text("Popular Characters")
                        .foregroundStyle(.white)
                    Spacer()
                    Button(action: {
                        viewModel.fetchCharacters(isInitialFetch: false)
                    }, label: {
                        Text("Show More")
                            .font(.system(size: 14))
                    })
                    .buttonStyle(.plain)
                }
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
                viewModel.fetchCharacters(isInitialFetch: true)
            }
        }
    }
}

#Preview {
    return CharacterListView()
}
