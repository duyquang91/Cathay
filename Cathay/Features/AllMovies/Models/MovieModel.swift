//
//  MovieModel.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional
import UIKit

public struct MovieModel: Identifiable, Decodable {
    
    private let posterImageURLString: String
    private let backDropImageURLString: String
    var posterImageURL: URL? {
        return URL(string: Constants.urlImageString + posterImageURLString)
    }
    var backDropImageURL: URL? {
        return URL(string: Constants.urlImageString + backDropImageURLString)
    }
    var posterImage: Single<UIImage> {
        if let posterImageURL = posterImageURL {
            return ImageAPIClient.shared.requestImageData(fromUrl: posterImageURL).map { UIImage(data: $0) }.asObservable().filterNil().asSingle()
        } else {
            return Single.error(APIErrors.failure)
        }
    }
    var backDropImage: Single<UIImage> {
        if let backDropImageURL = backDropImageURL {
            return ImageAPIClient.shared.requestImageData(fromUrl: backDropImageURL).map { UIImage(data: $0) }.asObservable().filterNil().asSingle()
        } else {
            return Single.error(APIErrors.failure)
        }
    }
        
    public let id: Int
    let title: String
    let popularity: Double
    let overView: String?
    let genres: [GenreModel]?

    
    enum CodingKeys: String, CodingKey {
        case id, title, popularity, genres
        case posterImageURLString = "poster_path"
        case backDropImageURLString = "backdrop_path"
        case overView = "overview"
    }
    
    static var mockData: [MovieModel] {
        let respone = try! Bundle.main.getObject(fromJsonFile: "AllMovies") as AllMoviesResponseModel
        return respone.results
    }
}

/*
{
    "popularity": 639.314,
    "vote_count": 5156,
    "video": false,
    "poster_path": "/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg",
    "id": 475557,
    "adult": false,
    "backdrop_path": "/n6bUvigpRFqSwmPp1m2YADdbRBc.jpg",
    "original_language": "en",
    "original_title": "Joker",
    "genre_ids": [
        80,
        18,
        53
    ],
    "title": "Joker",
    "vote_average": 8.5,
    "overview": "During the 1980s, a failed stand-up comedian is driven insane and turns to a life of crime and chaos in Gotham City while becoming an infamous psychopathic crime figure.",
    "release_date": "2019-10-04"
}
*/
