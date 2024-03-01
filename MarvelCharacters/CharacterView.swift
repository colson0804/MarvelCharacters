//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import SwiftUI

struct CharacterView: View {
    @State var characters: [Character] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Popular Characters")
                .foregroundStyle(.white)
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(characters, id: \.self) { character in
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
                .frame(height: UIScreen.main.bounds.height / 3)
            }
        }
        .padding()
        .onAppear {
            Task {
                let result = await MarvelService().getCharacters()
                switch result {
                case .success(let characters):
                    print(characters)
                    self.characters = characters
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    let characters = [Character(id: 1, name: "Loki", description: "", thumbnail: Thumbnail(path: "", extension: "jpg")),
                      Character(id: 2, name: "Thor", description: "", thumbnail: Thumbnail(path: "", extension: "jpg"))]
    return CharacterView(characters: characters)
}
