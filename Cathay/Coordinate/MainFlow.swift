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
        
    var root: Presentable {
        return navigationController
    }
    private let navigationController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MainSteps else { return .none }
        
        switch step {
        case .showAllMovie:
            let viewController = AllMoviesViewController()
            let viewModel = AllMoviesViewModel()
            navigationController.pushViewController(viewController, animated: true)
            
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
        
        case .showMovieDetail:
            let viewController = MovieDetailViewController()
            let viewModel = MovieDetailViewModel()
            navigationController.pushViewController(viewController, animated: true)
            
            return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewModel))
        }
    }
    
    
}
