//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    @State var characters: [Character] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Popular Characters")
                .foregroundStyle(.white)
            ListView(items: characters)
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
    return ContentView(characters: characters)
}
