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
    func loadAllMovie(page: Int) -> Single<MovieModel>
    func loadMovieDetail(id: String) -> Single<MovieModel>
}
