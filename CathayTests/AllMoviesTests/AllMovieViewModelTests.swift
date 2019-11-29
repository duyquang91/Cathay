//
//  ViewModelTests.swift
//  CathayTests
//
//  Created by Steve Dao on 29/11/19.
//  Copyright © 2019 Steve. All rights reserved.
//
@testable import Cathay
import UIKit
import XCTest
import RxTest
import RxSwift
import RxCocoa
import RxBlocking
import RxFlow

class AllMovieViewModelTests: XCTestCase {
    
    var viewModel: AllMoviesViewModel!
    var mockRepository: MovieRepositoryType!
    var testScheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var refreshTrigger: PublishRelay<Void>!
    var movieSelectedTrigger: PublishRelay<MovieModel>!
    
    override func setUp() {
        super.setUp()
        testScheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        refreshTrigger = PublishRelay<Void>()
        movieSelectedTrigger = PublishRelay<MovieModel>()
    }
    
    override func tearDown() {
        super.tearDown()
        testScheduler.stop()
        disposeBag = nil
    }
    
    func testLoadingState() {
        // Inject repository & prepare viewModel
        mockRepository = TestSuccessMovieRepository()
        viewModel = AllMoviesViewModel(movieRepository: mockRepository)
        // Prepare outputs
        let output = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                                         loadMoreTrigger: .empty(),
                                                                         showMovieDetailTrigger: .empty()))
        let recordedLoading = testScheduler.createObserver(Bool.self)
        output.isLoading.bind(to: recordedLoading).disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(10, ())]).bind(to: refreshTrigger).disposed(by: disposeBag)
        testScheduler.start()
        XCTAssertRecordedElements(recordedLoading.events, [false, true, false])
    }
    
    func testLoadAllMovieSuccess() {
        // Inject repository & prepare viewModel
        mockRepository = TestSuccessMovieRepository()
        viewModel = AllMoviesViewModel(movieRepository: mockRepository)
        // Prepare outputs
        let output = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                                         loadMoreTrigger: .empty(),
                                                                         showMovieDetailTrigger: movieSelectedTrigger.asObservable()))
        let recordedMovies = testScheduler.createObserver([MovieModel].self)
        output.movies.bind(to: recordedMovies).disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(10, ())]).bind(to: refreshTrigger).disposed(by: disposeBag)
        testScheduler.start()
        XCTAssertTrue(recordedMovies.events.isNotEmpty)
    }
    
    func testLoadAllMovieFailure() {
        // Inject repository & prepare viewModel
        mockRepository = TestFailureMovieRepository()
        viewModel = AllMoviesViewModel(movieRepository: mockRepository)
        // Prepare outputs
        let output = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                                         loadMoreTrigger: .empty(),
                                                                         showMovieDetailTrigger: .empty()))
        let recordedErrors = testScheduler.createObserver(Error.self)
        output.errors.bind(to: recordedErrors).disposed(by: disposeBag)
        testScheduler.createColdObservable([.next(10, ())]).bind(to: refreshTrigger).disposed(by: disposeBag)
        testScheduler.start()
        XCTAssertTrue(recordedErrors.events.isNotEmpty)
    }
    
    func testCoordinators() {
        // Inject repository & prepare viewModel
        mockRepository = TestSuccessMovieRepository()
        viewModel = AllMoviesViewModel(movieRepository: mockRepository)
        // Prepare outputs
        let output = viewModel.transform(input: AllMoviesViewModel.Input(refreshTrigger: refreshTrigger.asObservable(),
                                                                         loadMoreTrigger: .empty(),
                                                                         showMovieDetailTrigger: movieSelectedTrigger.asObservable()))
        let movie = try! mockRepository.loadAllMovies(page: 0)
            .toBlocking()
            .single()
        
        let recordedMovies = testScheduler.createObserver([MovieModel].self)
        output.movies.bind(to: recordedMovies).disposed(by: disposeBag)
        
        let recordedStep = testScheduler.createObserver(Step.self)
        viewModel.steps.asObservable()
            .bind(to: recordedStep)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(10, ())])
            .bind(to: refreshTrigger)
            .disposed(by: disposeBag)
        
        testScheduler.createColdObservable([.next(20, movie.results.first!)])
            .bind(to: movieSelectedTrigger)
            .disposed(by: disposeBag)
        
        testScheduler.start()
        
        XCTAssertTrue(recordedMovies.events.isNotEmpty)
        XCTAssertTrue(recordedStep.events.isNotEmpty)
    }
}
