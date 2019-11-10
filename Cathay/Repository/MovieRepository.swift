//
//  MovieRepository.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol MovieRepositoryType {
    func loadAllMovies(page: Int) -> Single<[MovieModel]>
    func loadMovieDetail(id: String) -> Single<MovieModel>
}

struct MockMovieRepository: MovieRepositoryType {
    
    func loadAllMovies(page: Int) -> Single<[MovieModel]> {
        return Single.just([MovieModel(id: "1234")])
    }
    
    func loadMovieDetail(id: String) -> Single<MovieModel> {
        return Single.just(MovieModel(id: "1234"))
    }
}
