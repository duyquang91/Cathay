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
}
