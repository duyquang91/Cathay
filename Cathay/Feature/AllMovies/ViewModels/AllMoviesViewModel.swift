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
import RxFlow
import Action

struct AllMoviesViewModel: ViewModelType, Stepper {
    
    // ViewModelType conformances
    struct Input {
        let refreshTrigger: Signal<Void>
        let loadMoreTrigger: Signal<Void>
        let showDetailTrigger: Signal<MovieModel>
    }
    
    struct Output {
        let movies: Driver<MovieModel>
        let errors: Signal<Error>
        let isLoading: Driver<Bool>
        let showDetailMovieId: Signal<String>
    }
    
    func transform(input: Input) -> Output {
        return Output(movies: Driver<MovieModel>,
                      errors: Signal<Error>,
                      isLoading: Driver<Bool>,
                      showDetailMovieId: input.showDetailTrigger.map { $0.id })
    }
    
    // Stepper conformances
    let steps = PublishRelay<Step>()
    
    func showMovieDetail(withId id: String) {
        steps.accept(MainSteps.showMovieDetail(withId: id))
    }
}
