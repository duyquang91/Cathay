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
        title = "All Movies"
        bindingViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshTrigger.accept(())
    }
    
    private func bindingViewModel() {
        // Embed SwiftUI
        let viewController = UIHostingController(rootView: AllMoviesView(movies: []))
        self.addChild(viewController)
        viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        viewController.view.frame = self.view.bounds
        self.view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
        
        // Binding
        let outputs = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                            loadMoreTrigger: loadMoreTrigger.asObservable(),
                                                            showMovieDetailTrigger: showMovieDetailTrigger.asObservable()))
        outputs.movies.asDriver(onErrorJustReturn: [])
            .drive(onNext: { movies in
                viewController.rootView.movies = movies
            })
            .disposed(by: disposeBag)
        
        outputs.isLoading
            .bind(to: self.view.rx.isLoadingHUD)
            .disposed(by: disposeBag)
        
        outputs.errors
            .bind(to: self.rx.errorAlert)
            .disposed(by: disposeBag)
        
        viewController.rootView.detailMovie
            .bind(to: showMovieDetailTrigger)
            .disposed(by: disposeBag)
    }
}
