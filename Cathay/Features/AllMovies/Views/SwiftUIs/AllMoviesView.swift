//
//  AllMoviesView.swift
//  Cathay
//
//  Created by Steve on 11/18/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import SwiftUI

struct AllMoviesView: View {
    
    var movies: [MovieModel]!
    
    init(movies: [MovieModel]) {
        self.movies = movies
    }
    
    var body: some View {
        List(movies) { MovieRow(movie: $0) }
    }
}

struct AllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesView(movies: MovieModel.mockData).previewDevice(PreviewDevice.init(rawValue: "iPhone SE"))
    }
}
