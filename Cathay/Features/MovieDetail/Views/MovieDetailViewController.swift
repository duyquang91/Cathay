//
//  MovieDetailViewController.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa
import RxOptional
import RxSwiftExt
import Reusable

class MovieDetailViewController: UIViewController, NibOwnerLoadable {
    
    var viewModel: MovieDetailViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movie Detail"
        
        rx.viewDidAppear.debug("tets").subscribe().disposed(by: disposeBag)

        let outputs = viewModel.transform(input: MovieDetailViewModel.Input(refreshTrigger: self.rx.viewDidAppear.mapTo(())))
        
        outputs.movieModel.debug("test")
            .subscribeOn(MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] movie in
                guard let self = self else { return }
                
                self.children.forEach { child in
                    child.view.removeFromSuperview()
                    child.removeFromParent()
                    child.didMove(toParent: nil)
                }
                
                let child = UIHostingController(rootView: MovieDetailView(movie: movie))
                child.view.frame = self.view.bounds
                child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.view.addSubview(child.view)
                self.addChild(child)
                child.didMove(toParent: self)
            })
            .disposed(by: disposeBag)
    }
}
