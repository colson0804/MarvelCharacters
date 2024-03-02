//
//  ComicListView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/2/24.
//

import SwiftUI

struct ComicListView: View {
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Comics")
                .foregroundStyle(.white)
//            ListView(items: viewModel.characters) { selectedItem in
////                viewModel.selectCharacter(selectedItem)
//            }
        }
        .padding()
        .onAppear {
//            viewModel.fetchCharacters()
        }
    }
}

#Preview {
    ComicListView()
}
