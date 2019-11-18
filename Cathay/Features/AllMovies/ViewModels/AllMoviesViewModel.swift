//
//  AllMoviesViewModel.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxOptional
import RxFlow
import Action

class AllMoviesViewModel: ViewModelType, Stepper {
    
    private let movieRepository: MovieRepositoryType
    private let disposeBag = DisposeBag()
    private lazy var loadAllMoviesAction = Action<Int, AllMoviesResponseModel>(workFactory: { page -> Single<AllMoviesResponseModel> in
        return self.movieRepository.loadAllMovies(page: page)
    })
    
    init(movieRepository: MovieRepositoryType) {
        self.movieRepository = movieRepository
    }
    
    // ViewModelType conformances
    struct Input {
        let refreshTrigger: Observable<Void>
        let loadMoreTrigger: Observable<Void>
        let showMovieDetailTrigger: Observable<MovieModel>
    }
    
    struct Output {
        let movies: Observable<[MovieModel]>
        let errors: Observable<Error>
        let isLoading: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        input.showMovieDetailTrigger
            .map { "\($0.id)" }
            .map { MainSteps.showMovieDetail(withId: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.refreshTrigger.map { 0 }.bind(to: loadAllMoviesAction.inputs).disposed(by: disposeBag)
        
        return Output(movies: loadAllMoviesAction.elements.map { $0.results },
                      errors: loadAllMoviesAction.underlyingError,
                      isLoading: loadAllMoviesAction.executing)
    }
    
    // Stepper conformances
    let steps = PublishRelay<Step>()
}
