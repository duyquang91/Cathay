//
//  ModelTests.swift
//  CathayTests
//
//  Created by Steve on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import XCTest
@testable import Cathay

class ModelTests: XCTestCase {
    
    func testAllMovieModel() {
        XCTAssertNoThrow(try Bundle.main.getObject(fromJsonFile: "AllMovies") as AllMoviesResponseModel)
    }
    
    func testMovieDetailModel() {
        XCTAssertNoThrow(try Bundle.main.getObject(fromJsonFile: "MovieDetail") as MovieModel)
    }
    
    func testMovieModelEqual() {
        let movie1 = try! Bundle.main.getObject(fromJsonFile: "MovieDetail") as MovieModel
        let movie2 = movie1
        XCTAssertEqual(movie1, movie2)
    }
    
    func testMovieModelUrlImage() {
        let movie = try! Bundle.main.getObject(fromJsonFile: "MovieDetail") as MovieModel
        XCTAssertNotNil(movie.posterImageURL)
        XCTAssertNotNil(movie.backDropImageURL)
    }
    
    func testMockData() {
        XCTAssertTrue(MovieModel.mockData.isNotEmpty)
    }
}
