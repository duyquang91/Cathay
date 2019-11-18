//
//  MovieRow.swift
//  Cathay
//
//  Created by Steve on 11/18/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import SwiftUI

struct MovieRow: View {
    
    var movie: MovieModel!
    
    init(movie: MovieModel) {
        self.movie = movie
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            Text(movie.title).font(.body)
            Text(movie.overView ?? "").font(.caption).lineLimit(3).foregroundColor(Color.gray)
        })
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        MovieRow(movie: MovieModel.mockData.first!).previewDevice(PreviewDevice(rawValue: "iPhone SE"))
    }
}
