//
//  ComicListView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/2/24.
//

import SwiftUI

struct ComicListView: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(character: Character) {
        viewModel = ViewModel(character: character)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack {
                Text(viewModel.selectedCharacter.name)
                    .foregroundStyle(.white)
                Spacer()
                Button(action: {
                    viewModel.fetchComics(isInitialFetch: false)
                }, label: {
                    Text("Show More")
                        .font(.system(size: 14))
                })
                .buttonStyle(.plain)
            }
            if viewModel.comics.isEmpty {
                Text("No comics found for \(viewModel.selectedCharacter.name)")
            } else {
                ListView(items: viewModel.comics) { comic in
                    ComicView(comic: comic)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.fetchComics(isInitialFetch: true)
        }
    }
}

#Preview {
    let character = Character(id: 1, name: "Black Widow", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
    return ComicListView(character: character)
}
