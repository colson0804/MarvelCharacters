//
//  ListView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

import SwiftUI

struct ListView<Data: Identifiable & Hashable, Destination: View>: View {
    var items: [Data]
    var destination: (Data) -> Destination
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(items, id: \.self) { item in
                    destination(item)
                }
            }
            .frame(height: UIScreen.main.bounds.height / 3)
        }
    }
}

#Preview {
    let character = Character(id: 1, name: "Iron Man", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))
    return ListView<Character, CharacterView>(items: [], destination: { _ in CharacterView(character: character) })
}
