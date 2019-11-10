//
//  MainFlow.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import UIKit
import RxFlow

class MainFlow: Flow {
    
    private let navigationController = UINavigationController()
    
    //Dependencies
    private let movieService = MockMovieRepository()
        
    // Flow conformances
    var root: Presentable {
        return navigationController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .showAllMovie:
            let viewController = AllMoviesViewController()
            let viewModel = AllMoviesViewModel(movieRepository: movieService)
            navigationController.pushViewController(viewController, animated: true)
            
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
        
        case .showMovieDetail(let id):
            let viewController = MovieDetailViewController()
            let viewModel = MovieDetailViewModel(movieId: id, movieRepository: movieService)
            navigationController.pushViewController(viewController, animated: true)
            
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
        }
    }
}
