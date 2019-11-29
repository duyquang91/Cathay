//
//  TestMovieRepository.swift
//  CathayTests
//
//  Created by Steve Dao on 29/11/19.
//  Copyright © 2019 Steve. All rights reserved.
//
@testable import Cathay
import Foundation
import RxSwift
import RxCocoa

struct TestSuccessMovieRepository: MovieRepositoryType {
    
    func loadAllMovies(page: Int) -> Single<AllMoviesResponseModel> {
        let object: AllMoviesResponseModel = try! Bundle.main.getObject(fromJsonFile: "AllMovies")
        return .just(object)
    }
    
    func loadMovieDetail(id: String) -> Single<MovieModel> {
        let object: MovieModel = try! Bundle.main.getObject(fromJsonFile: "MovieDetail")
        return Single.just(object).delay(.seconds(2), scheduler: MainScheduler.instance)
    }
}

struct TestFailureMovieRepository: MovieRepositoryType {
    
    func loadAllMovies(page: Int) -> Single<AllMoviesResponseModel> {
        return .error(NSError(domain: "", code: 400, userInfo: nil))
    }
    
    func loadMovieDetail(id: String) -> Single<MovieModel> {
        return .error(NSError(domain: "", code: 400, userInfo: nil))
        
    }
}
