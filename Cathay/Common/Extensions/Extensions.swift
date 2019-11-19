//
//  Extensions.swift
//  Cathay
//
//  Created by Steve on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional
import SwiftUI

extension Bundle {
    func getObject<T: Decodable>(fromJsonFile: String) throws -> T {
        guard let filePath = url(forResource: fromJsonFile, withExtension: "json") else { fatalError("File not found!") }
        
        let data = try Data(contentsOf: filePath)
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    }
}

