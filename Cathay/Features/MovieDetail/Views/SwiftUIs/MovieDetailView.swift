//
//  MovieDetailView.swift
//  Cathay
//
//  Created by Steve Dao on 19/11/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    
    let movie: MovieModel?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4, content: {
            WebImage(url: movie?.backDropImageURL).resizable().scaledToFit()
            Text(movie?.title ?? "").font(.title).bold()
            Text(movie?.overView ?? "").font(.subheadline).italic()
        }).frame(alignment: .top)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: MovieModel.mockData.first!)
            .previewDevice(PreviewDevice.init(rawValue: "iPhone SE"))
    }
}
