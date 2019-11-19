//
//  MovieRow.swift
//  Cathay
//
//  Created by Steve on 11/18/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {
    
    var movie: MovieModel
    
    var body: some View {
        HStack {
            WebImage(url: movie.posterImageURL).resizable().animation(.easeInOut(duration: 0.35)).transition(.fade).scaledToFit().frame(maxHeight: 150)
            VStack(alignment: .leading, spacing: 4, content: {
                Text(movie.title).font(.body)
                Text(movie.overView ?? "").font(.caption).lineLimit(7).foregroundColor(Color.gray)
            }).frame(maxHeight: 150, alignment: .top)
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: MovieModel.mockData.first!).previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
