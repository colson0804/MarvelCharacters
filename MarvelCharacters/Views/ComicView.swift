//
//  ComicView.swift
//  MarvelCharacters
//
//  Created by Craig Olson on 3/2/24.
//

import SwiftUI

struct ComicView: View {
    let comic: Comic
    
    var body: some View {
        VStack {
            AsyncImage(url: comic.thumbnail.url) { image in
                image.image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipped()
                    .overlay {
                        Rectangle().stroke(Color.white, lineWidth: 2)
                    }
            }
            Text(comic.title)
                .font(.footnote)
            Spacer()
        }
        .focusable()
        .frame(width: 200)
        .padding(5)
    }
}
