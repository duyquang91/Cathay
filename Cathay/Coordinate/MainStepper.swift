//
//  MainStepper.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxCocoa
import RxFlow

class MainStepper: Stepper {
    let steps = PublishRelay<Step>()
    
    let initialStep = MainSteps.showAllMovie
    
    func readyToEmitSteps() {
        steps.accept(MainSteps.showAllMovie)
    }
}
