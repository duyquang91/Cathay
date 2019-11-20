//
//  Extensions.swift
//  Cathay
//
//  Created by Steve on 11/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
    func getObject<T: Decodable>(fromJsonFile: String) throws -> T {
        guard let filePath = url(forResource: fromJsonFile, withExtension: "json") else { fatalError("File not found!") }
        
        let data = try Data(contentsOf: filePath)
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    }
}

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension NSError {
    static var wrongJsonFormat: NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Wrong JSON data format!"])
    }
    static var mockError: NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "This is a mock Error for testing purpose!"])
    }
}
