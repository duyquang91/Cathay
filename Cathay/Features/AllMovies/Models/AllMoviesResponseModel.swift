//
//  AllMoviesResponseModel.swift
//  Cathay
//
//  Created by Steve on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation

struct AllMoviesResponseModel: Decodable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [MovieModel]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

/*
 {
 "page": 1,
 "total_results": 10000,
 "total_pages": 500,
 "results": []
 }
 */
