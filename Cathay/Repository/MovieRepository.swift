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
    func loadAllMovies(page: Int) -> Single<AllMoviesResponseModel>
    func loadMovieDetail(id: String) -> Single<MovieModel>
}

struct MockMovieRepository: MovieRepositoryType {
    
    func loadAllMovies(page: Int) -> Single<AllMoviesResponseModel> {
        do {
            let object: AllMoviesResponseModel = try Bundle.main.getObject(fromJsonFile: "AllMoviews")
            return Single.just(object)
        } catch (let error) {
            return Single.error(error)
        }
    }
    
    func loadMovieDetail(id: String) -> Single<MovieModel> {
        do {
            let object: MovieModel = try Bundle.main.getObject(fromJsonFile: "MovieDetail")
            return Single.just(object)
        } catch (let error) {
            return Single.error(error)
        }
    }
}
