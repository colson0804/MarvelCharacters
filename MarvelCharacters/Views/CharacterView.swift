//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/29/24.
//

import SwiftUI

struct CharacterView: View {
    var character: Character
    
    var body: some View {
        VStack {
            AsyncImage(url: character.thumbnail.url) { image in
                image.image?.resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .overlay {
                        Circle().stroke(Color.white, lineWidth: 2)
                    }
            }
            .frame(width: 200, height: 200)
            Text(character.name)
                .font(.footnote)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .focusable()
        .frame(width: 200)
        .padding(5)
    }
}

#Preview {
    CharacterView(character: Character(id: 1, name: "Captain America", description: "", thumbnail: Thumbnail(path: "", extension: "jpg")))
}
