//
//  ContentView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            Task {
                await MarvelService().getCharacters()
            }
        }
    }
}

#Preview {
    ContentView()
}
