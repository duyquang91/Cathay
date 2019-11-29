//
//  RepositoryTests.swift
//  CathayTests
//
//  Created by Steve on 11/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

@testable import Cathay
import UIKit
import XCTest
import RxSwift
import RxCocoa
import RxBlocking
import OHHTTPStubs

class RepositoryTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        guard let filePath = Bundle.main.url(forResource: "AllMovies", withExtension: "json")
            else { fatalError("File not found!") }
        let data = try! Data(contentsOf: filePath)
        stub(condition: isHost("testsuccess.com")) { _ in OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil) }
        stub(condition: isHost("testfail.com")) { _ in OHHTTPStubsResponse(jsonObject: [:], statusCode: 200, headers: nil) }
    }
    
    override func tearDown() {
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testAPICLientSucess() {
        let request = APIRequest(url: "http://testsuccess.com", method: .get)
        let result: Single<AllMoviesResponseModel> = APIClient.shared.request(request: request)
        let response = try? result.toBlocking().single()
        XCTAssertNotNil(response)
    }
    
    func testAPICLientFail() {
        let request = APIRequest(url: "http://testfail.com", method: .get)
        let result: Single<AllMoviesResponseModel> = APIClient.shared.request(request: request)
        let error = try? result.asObservable().materialize().map { $0.error }.filterNil().toBlocking().single()
        XCTAssertNotNil(error)
    }
    
    func testApiRequest() {
        let request = APIRequest(url: "http://test.com", method: .get)
        let urlRequest = URLRequest(url: URL(string: "http://test.com")!)
        
        XCTAssertEqual(request.urlRequest, urlRequest)
    }
    
    func testMovieRepository() {
        let successRepository = TestSuccessMovieRepository()
        let movies = try? successRepository.loadAllMovies(page: 0).toBlocking().single()
        let movie = try? successRepository.loadMovieDetail(id: "").toBlocking().single()
        
        XCTAssertNotNil(movies)
        XCTAssertNotNil(movie)
    }
}
