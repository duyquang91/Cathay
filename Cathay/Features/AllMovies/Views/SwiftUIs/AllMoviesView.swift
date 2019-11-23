//
//  AllMoviesView.swift
//  Cathay
//
//  Created by Steve on 11/18/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import SwiftUI
import RxSwift
import RxCocoa

struct AllMoviesView: View {
    
    var movies: [MovieModel]!
    var detailMovie = PublishRelay<MovieModel>()
    
    init(movies: [MovieModel]) {
        self.movies = movies
    }
    
    var body: some View {
        List(movies) { movie in
            return MovieRow(movie: movie).onTapGesture { self.detailMovie.accept(movie) }
        }
    }
}

struct AllMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        AllMoviesView(movies: MovieModel.mockData).previewDevice(PreviewDevice.init(rawValue: "iPhone SE"))
    }
}




