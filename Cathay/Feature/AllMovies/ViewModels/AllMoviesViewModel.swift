//
//  AllMoviesViewModel.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxCocoa
import RxFlow

class AllMoviesViewModel: Stepper {
    
    let steps = PublishRelay<Step>()
    
    func showMovieDetail() {
        steps.accept(MainSteps.showMovieDetail)
    }
}
