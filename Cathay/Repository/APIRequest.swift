//
//  APIRequest.swift
//  Cathay
//
//  Created by Steve on 11/9/19.
//  Copyright © 2019 Steve. All rights reserved.
//

import Foundation

protocol URLRequestConvertable {
    var urlRequest: URLRequest { get }
}

struct APIRequest: URLRequestConvertable {
    enum HTTPMethod: String {
        case get, post, put, delete
    }
    let url: String
    let method: HTTPMethod
    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        return request
    }

}
