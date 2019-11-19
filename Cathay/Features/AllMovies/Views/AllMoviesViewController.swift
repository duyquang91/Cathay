//
//  AllMoviesViewController.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import UIKit
import Reusable
import SwiftUI
import RxSwift
import RxCocoa

class AllMoviesViewController: UIViewController, NibOwnerLoadable {
    
    var viewModel: AllMoviesViewModel!
    
    private let refreshTrigger = PublishRelay<Void>()
    private let loadMoreTrigger = PublishRelay<Void>()
    private let showMovieDetailTrigger = PublishRelay<MovieModel>()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewController = UIHostingController(rootView: AllMoviesView(movies: MovieModel.mockData))
        self.addChild(viewController)
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewController.view.frame = self.view.bounds
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)

        title = "All Movies"
        
        let outputs = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                            loadMoreTrigger: loadMoreTrigger.asObservable(),
                                                            showMovieDetailTrigger: showMovieDetailTrigger.asObservable()))
        outputs.movies.asDriver(onErrorJustReturn: [])
            .debug("outputs.movies")
            .drive(onNext: { movies in
                viewController.rootView.movies = movies
            })
            .disposed(by: disposeBag)
        
        viewController.rootView.detailMovie
            .bind(to: showMovieDetailTrigger)
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshTrigger.accept(())
    }
}
