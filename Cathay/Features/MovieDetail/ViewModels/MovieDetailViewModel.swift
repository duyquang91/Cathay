//
//  MovieDetailViewModel.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxFlow
import Action

class MovieDetailViewModel: ViewModelType, Stepper {
    
    private lazy var loadMovieDetailAction = Action<String, MovieModel> { id -> Single<MovieModel> in
        return self.movieRepository.loadMovieDetail(id: id)
    }
    private let disposeBag = DisposeBag()
    
    // ViewModelType conformances
    struct Input {
        let refreshTrigger: Observable<Void>
    }
    
    struct Output {
        let movieModel: Observable<MovieModel>
        let isLoading: Observable<Bool>
        let errors: Observable<Error>
    }
    
    func transform(input: MovieDetailViewModel.Input) -> MovieDetailViewModel.Output {
        input.refreshTrigger
            .mapTo(movieId)
            .bind(to: loadMovieDetailAction.inputs)
            .disposed(by: disposeBag)
        
        return Output(movieModel: loadMovieDetailAction.elements,
                      isLoading: loadMovieDetailAction.executing,
                      errors: loadMovieDetailAction.underlyingError)
    }
    
    // Dependencies
    private let movieRepository: MovieRepositoryType
    
    // Stepper conformances
    let steps = PublishRelay<Step>()
    
    // Private properties
    private let movieId: String
    
    init(movieId: String, movieRepository: MovieRepositoryType) {
        self.movieId = movieId
        self.movieRepository = movieRepository
    }
}
