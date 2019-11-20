//
//  Reactive+Extensions.swift
//  Cathay
//
//  Created by Steve on 11/20/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxOptional
import MBProgressHUD

extension RxSwift.Reactive where Base: UIViewController {
    public var viewDidLoad: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLoad))
            .map { _ in return }
    }
    
    public var viewDidLayoutSubviews: Observable<Void> {
        return methodInvoked(#selector(UIViewController.viewDidLayoutSubviews))
            .map { _ in return }
    }
    
    public var viewWillAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewDidAppear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidAppear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewWillDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewWillDisappear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var viewDidDisappear: Observable<Bool> {
        return methodInvoked(#selector(UIViewController.viewDidDisappear))
            .map { $0.first as? Bool ?? false }
    }
    
    public var errorAlert: Binder<Error> {
        return Binder<Error>.init(base.self, scheduler: MainScheduler.instance) { viewController, error in
            viewController.showAlert(title: "Error", message: error.localizedDescription)
        }
    }
}

extension Reactive where Base: UIView {
    public var isLoadingHUD: Binder<Bool> {
        return Binder<Bool>.init(base.self, scheduler: MainScheduler.instance) { view, isLoading in
            if isLoading {
                MBProgressHUD.showAdded(to: view, animated: true)
            } else {
                MBProgressHUD.hide(for: view, animated: true)
            }
        }
    }
}
