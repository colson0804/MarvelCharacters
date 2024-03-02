//
//  ListView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

import SwiftUI

struct ListView<T: Identifiable & Hashable>: View {
    var items: [T]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(items, id: \.self) { item in
                    if let character = item as? Character {
                        NavigationLink(destination: {
                            ComicListView()
                        }, label: {
                            CharacterView(character: character)
                        })
                        .buttonStyle(.plain)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.height / 3)
        }
    }
}

#Preview {
    ListView<Character>(items: [])
}
